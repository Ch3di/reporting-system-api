import Foundation
import Fluent
import Vapor

struct UserData: Content {
    let name: String
}

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: getAllHandler)
        users.post(use: createHandler)
        users.group(":id") { user in
            user.get(use: getHandler)
            user.delete(use: deleteHandler)
            user.get("reports", use: getReportsHandler)
        }
    }

    func getAllHandler(req: Request) throws -> EventLoopFuture<[User.Public]> {
        User.query(on: req.db)
        .all()
        .flatMapThrowing { users -> [User.Public] in
            var usersAsPublic: [User.Public] = []
            for user in users {
                usersAsPublic.append(user.asPublic())
            }
            return usersAsPublic
        }
    }
    
    func getHandler(req: Request) throws -> EventLoopFuture<User.Public> {
        guard let userID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return User.query(on: req.db)
                .filter(\.$id == userID)
                .first()
                .unwrap(or: Abort(.notFound))
                .map { user in 
                    user.asPublic()
                }
    }
    
    func createHandler(req: Request) throws -> EventLoopFuture<User.Public> {
        let userData = try req.content.decode(UserData.self)
        let user = User(name: userData.name)
        return user.save(on: req.db).map { user.asPublic() }
    }

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let userID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return User.find(userID, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap { $0.delete(on: req.db) }
                .transform(to: .ok)
    }

    func getReportsHandler(_ req: Request) throws -> EventLoopFuture<[Report.Public]> {
        guard let userID: UUID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return User.find(userID, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap { user in
                    user.$issuedReports.get(on: req.db).flatMapThrowing { reports in
                        var reportsAsPublic: [Report.Public] = []
                        for report in reports {
                                reportsAsPublic.append(report.asPublic())
                        }
                        return reportsAsPublic
                    }
                }
    }
}
