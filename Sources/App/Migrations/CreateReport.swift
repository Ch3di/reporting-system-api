import Fluent

struct CreateReport: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("reports")
                .id()
                .field("details", .string)
                .field("reporter_id", .uuid)
                .field("reported_id", .uuid)
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .field("deleted_at", .datetime)
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("reports").delete()
    }
}
