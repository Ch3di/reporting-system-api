import Fluent
import Vapor
import Foundation
import FluentPostgresDriver
struct ReportData: Content {
    let reporter: UUID
    let reported: UUID
    let details: String?
    let categoryIDs: [UUID]
}

struct ReportController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let reports = routes.grouped("reports")

        reports.get(use: getAllHandler)
        reports.post(use: createHandler)
        reports.group(":id") { report in
            report.get(use: getHandler)
            report.get("categories", use: getReportCategoriesHandler)
            report.delete(use: deleteHandler)
        }
    }

    func getAllHandler(req: Request) throws -> EventLoopFuture<[Report.Public]> {
        Report.query(on: req.db)
        .all()
        .flatMapThrowing { reports -> [Report.Public] in
            var reportsAsPublic: [Report.Public] = []
            for report in reports {
                reportsAsPublic.append(report.asPublic())
            }
            return reportsAsPublic
        }
    }

    func getHandler(req: Request) throws -> EventLoopFuture<Report.Public> {
        guard let reportID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Report.query(on: req.db)
                .filter(\.$id == reportID)
                .with(\.$categories)
                .first()
                .unwrap(or: Abort(.notFound))
                .map { report in 
                    report.asPublic()
                }
    }


    func createHandler(req: Request) throws -> EventLoopFuture<Report.Public> {
        let reportData = try req.content.decode(ReportData.self)
        
        let reporterQuery = User.query(on: req.db)
                .filter(\.$id == reportData.reporter)
                .first()
                .unwrap(or: Abort(.notFound))
        
        let reportedQuery = User.query(on: req.db)
                            .filter(\.$id == reportData.reported)
                            .first()
                            .unwrap(or: Abort(.notFound))
        let report = Report()

        return reporterQuery.and(reportedQuery).flatMapThrowing {reporter, reported in
            let categoryIDs = reportData.categoryIDs
            report.setReporter(reporter: reporter)
            report.setReported(reported: reported)
            report.setDetails(details: reportData.details)
            let _ = report.save(on: req.db)
            for categoryID in categoryIDs {
                var _ = Category.query(on: req.db)
                            .filter(\.$id == categoryID)
                            .first()
                            .unwrap(or: Abort(.notFound))
                            .map { category in
                                report.$categories.attach(category, on: req.db)
                            }
            }
            return report.asPublic()
        }
    }

    func getReportCategoriesHandler(req: Request) throws -> EventLoopFuture<[Category.Public]> {
        guard let reportID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Report.query(on: req.db)
        .filter(\.$id == reportID)
        .first()
        .unwrap(or: Abort(.notFound))
        .flatMap { report in
            report.$categories.query(on: req.db)
                    .all()
                    .flatMapThrowing { categories in
                        var categoriesAsPublic: [Category.Public] = []
                        for category in categories {
                            categoriesAsPublic.append(category.asPublic())
                        }
                        return categoriesAsPublic
                    }
        }
    }

    func deleteHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let reportID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Report.query(on: req.db)
                .filter(\.$id == reportID)
                .first()
                .unwrap(or: Abort(.notFound))
                .flatMap { report in
                    report.delete(on: req.db)
                            .transform(to: .noContent)
                }
    }
}
