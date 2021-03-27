import Fluent

struct CreateCategory: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Category.schema)
                .id()
                .field(Category.FieldKeys.name, .string, .required)
                .field(Category.FieldKeys.description, .string)
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Category.schema).delete()
    }
}
