import Fluent

struct CreateReport: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Report.schema)
                .id()
                .field(Report.FieldKeys.details, .string)
                .field(Report.FieldKeys.reporter, .uuid)
                .field(Report.FieldKeys.reported, .uuid)
                .field(Report.FieldKeys.createdAt, .datetime)
                .field(Report.FieldKeys.updatedAt, .datetime)
                .field(Report.FieldKeys.deletedAt, .datetime)
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Report.schema).delete()
    }
}
