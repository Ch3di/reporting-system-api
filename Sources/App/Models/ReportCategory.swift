//
// Created by chady on 1/21/21.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class ReportCategory: Model {
    static let schema: String = "reports_categories"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "report_id")
    var report: Report

    @Parent(key: "category_id")
    var category: Category

    init() {}

    init(id: UUID? = nil, report: Report, category: Category) throws {
        self.id = id
        self.$report.id = try report.requireID()
        self.$category.id = try category.requireID()
    }

}