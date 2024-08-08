import Fluent

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .field("user_id", .int, .identifier(auto: true))
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("login_attempts", .int, .required, .default(0))
            .field("last_login_attempt", .datetime)
            .field("remember_me_token", .string)
            .field("created_at", .datetime, .required, .default(.now))
            .field("updated_at", .datetime, .required, .default(.now), .onUpdate(.now))
            .unique(on: "username")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
