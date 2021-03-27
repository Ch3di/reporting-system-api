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

    @ID(key: .id)
    var id: UUID?

    @Field(key: "details")
    var details: String?

    @Parent(key: "reporter_id")
    var reporter: User

    @Parent(key: "reported_id")
    var reported: User

    @Siblings(through: ReportCategory.self, from: \.$report, to: \.$category)
    var categories: [Category]

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
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
        // var categoryIDs: [UUID?]? = []
        // for category in self.categories {
        //     categoryIDs?.append(category.id)
        // }

        return Public(reportID: self.id, reporterID: self.$reporter.id, reportedID: self.$reported.id, details: self.details)

    }
}
