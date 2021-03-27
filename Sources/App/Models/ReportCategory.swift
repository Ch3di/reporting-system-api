import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class ReportCategory: Model {
    static let schema: String = "reports_categories"
    struct FieldKeys {
        static var report: FieldKey { "report_id" }
        static var category: FieldKey { "category_id" }
    }

    @ID(key: .id)
    var id: UUID?

    @Parent(key: FieldKeys.report)
    var report: Report

    @Parent(key: FieldKeys.category)
    var category: Category

    init() {}

    init(id: UUID? = nil, report: Report, category: Category) throws {
        self.id = id
        self.$report.id = try report.requireID()
        self.$category.id = try category.requireID()
    }

}