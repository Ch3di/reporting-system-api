import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class User: Model, Content {
    static let schema = "users"
    
     struct Public: Content {
        let id: UUID?
        let name: String
    }

    struct FieldKeys {
        static var name: FieldKey { "name" }
    }


    @ID(key: .id)
    var id: UUID?

    @Field(key: FieldKeys.name)
    var name: String

    @Children(for: \.$reporter)
    var issuedReports: [Report]


    init() { }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }

    func asPublic() -> Public{
        return Public(id: self.id, name: self.name)
    }
}