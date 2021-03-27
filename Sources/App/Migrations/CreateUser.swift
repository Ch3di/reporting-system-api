import Foundation
import Fluent

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema)
                .id()
                .field(User.FieldKeys.name, .string, .required)
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema).delete()
    }
}