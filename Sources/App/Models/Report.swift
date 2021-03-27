import Fluent
import Vapor
import Foundation
final class Report: Model, Content {
    static let schema = "reports"

    struct Public: Content {
        let reportID: UUID?
        let reporterID: UUID
        let reportedID: UUID
        let details: String?
    }

    struct FieldKeys {
        static var details: FieldKey { "details" }
        static var reporter: FieldKey { "reporter_id" }
        static var reported: FieldKey { "reported_id" }
        static var createdAt: FieldKey { "created_at" }
        static var updatedAt: FieldKey { "updated_at" }
        static var deletedAt: FieldKey { "deleted_at" }
    }


    @ID(key: .id)
    var id: UUID?

    @Field(key: FieldKeys.details)
    var details: String?

    @Parent(key: FieldKeys.reporter)
    var reporter: User

    @Parent(key: FieldKeys.reported)
    var reported: User

    @Siblings(through: ReportCategory.self, from: \.$report, to: \.$category)
    var categories: [Category]

    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?

    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?

    @Timestamp(key: FieldKeys.deletedAt, on: .delete)
    var deletedAt: Date?



    init() { }

    init(id: UUID? = nil, reporterId: UUID, reportedId: UUID, details: String? = nil) {
        self.id = id
        self.$reporter.id = reporterId
        self.$reported.id = reportedId
        self.details = details
    }

    func setReporter(reporter: User) {
        if let uuid = reporter.id {
            self.$reporter.id = uuid
        }
    }

    func setReported(reported: User) {
        if let uuid = reported.id {
            self.$reported.id = uuid
        }
    }

    func setDetails(details: String?) {
        if let det = details {
            self.details = det

        }
    }

    func asPublic() -> Public {
        return Public(reportID: self.id, reporterID: self.$reporter.id, reportedID: self.$reported.id, details: self.details)
    }
}
