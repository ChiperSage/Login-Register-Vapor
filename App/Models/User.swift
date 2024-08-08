import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"

    @ID(custom: "user_id", generatedBy: .server)
    var id: Int?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Field(key: "login_attempts")
    var loginAttempts: Int

    @Field(key: "last_login_attempt")
    var lastLoginAttempt: Date?

    @Field(key: "remember_me_token")
    var rememberMeToken: String?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: Int? = nil, username: String, password: String, loginAttempts: Int = 0, lastLoginAttempt: Date? = nil, rememberMeToken: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.username = username
        self.password = password
        self.loginAttempts = loginAttempts
        self.lastLoginAttempt = lastLoginAttempt
        self.rememberMeToken = rememberMeToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
