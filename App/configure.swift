import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateUser())

    app.views.use(.leaf)

    try routes(app)
}
