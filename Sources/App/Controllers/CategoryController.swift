import Fluent
import Vapor

struct CategoryData: Content {
    let name: String
    let description: String?
}
struct PatchCategoryData: Content {
    let name: String?
    let description: String?
}
struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let category = routes.grouped("categories")

        category.get(use: getAllHandler)
        category.post(use: createHandler)
        category.group(":id") { category in
            category.get(use: getHandler)
            category.patch(use: updateHandler)
            category.delete(use: deleteHandler)
            category.get("reports", use: getReports)
        }
    }

    func getHandler(req: Request) throws -> EventLoopFuture<Category.Public> {
        guard let categoryID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Category.query(on: req.db)
        .filter(\.$id == categoryID)
        .first()
        .unwrap(or: Abort(.notFound))
        .map { category in 
            category.asPublic()
        }
    }


    func getAllHandler(req: Request) throws -> EventLoopFuture<[Category.Public]> {
        Category.query(on: req.db)
        .all()
        .flatMapThrowing { categories -> [Category.Public] in
            var categoriesAsPublic: [Category.Public] = []
            for category in categories {
                categoriesAsPublic.append(category.asPublic())
            }
            return categoriesAsPublic
        }
    }

    func createHandler(req: Request) throws -> EventLoopFuture<Category> {
        let categoryData = try req.content.decode(CategoryData.self)
        let category = Category(name: categoryData.name)
        if let description = categoryData.description {
            category.setDescription(description: description)
        }
        return category.save(on: req.db).map { category }
    }

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let categoryID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Category.find(categoryID, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap { $0.delete(on: req.db) }
                .transform(to: .ok)
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Category.Public> {
        guard let categoryID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let patchData = try req.content.decode(PatchCategoryData.self)
        return Category.query(on: req.db)
                .filter(\.$id == categoryID)
                .first()
                .unwrap(or: Abort(.notFound))
                .flatMap { category in
                    category.name = patchData.name ?? category.name
                    category.description = patchData.description ?? category.description
                    return category.save(on: req.db).flatMapThrowing {
                        category.asPublic()
                    }
                }
    }

    func getReports(req: Request) throws -> EventLoopFuture<[Report.Public]> {
        guard let categoryID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Category.query(on: req.db)
        .filter(\.$id == categoryID)
        .first()
        .unwrap(or: Abort(.notFound))
        .flatMap { category in
            category.$report.query(on: req.db)
                    .all()
                    .flatMapThrowing { reports in
                        var reportsAsPublic: [Report.Public] = []
                        for report in reports {
                            reportsAsPublic.append(report.asPublic())
                        }
                        return reportsAsPublic
                    }
        }
    }

}
