import Fluent
import Vapor

struct AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let authRoutes = routes.grouped("auth")
        authRoutes.get("register", use: renderRegister)
        authRoutes.get("login", use: renderLogin)
        authRoutes.post("register", use: register)
        authRoutes.post("login", use: login)
    }

    func renderRegister(req: Request) -> EventLoopFuture<View> {
        return req.view.render("register")
    }

    func renderLogin(req: Request) -> EventLoopFuture<View> {
        return req.view.render("login")
    }

    func register(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.content.decode(RegisterRequest.self)
        let hashedPassword = try Bcrypt.hash(user.password)
        
        let newUser = User(
            username: user.username,
            password: hashedPassword,
            loginAttempts: 0
        )
        
        return newUser.save(on: req.db).map {
            req.redirect(to: "/auth/login")
        }
    }

    func login(req: Request) throws -> EventLoopFuture<Response> {
        let loginRequest = try req.content.decode(LoginRequest.self)
        
        return User.query(on: req.db)
            .filter(\.$username == loginRequest.username)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { user in
                guard try Bcrypt.verify(loginRequest.password, created: user.password) else {
                    user.loginAttempts += 1
                    user.lastLoginAttempt = Date()
                    return user.save(on: req.db).flatMapThrowing { _ in
                        throw Abort(.unauthorized)
                    }
                }
                
                user.loginAttempts = 0
                user.lastLoginAttempt = Date()
                return user.save(on: req.db).map {
                    req.redirect(to: "/welcome")
                }
            }
    }
}

struct RegisterRequest: Content {
    let username: String
    let password: String
}

struct LoginRequest: Content {
    let username: String
    let password: String
}
