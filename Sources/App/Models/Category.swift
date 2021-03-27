import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Category: Model, Content {
    struct Public: Content {
        let id: UUID?
        let name: String
        let description: String?
    }
    
    static let schema = "categories"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "description")
    var description: String?

    @Siblings(through: ReportCategory.self, from: \.$category, to: \.$report)
    var report: [Report]


    init() { }

    init(id: UUID? = nil, name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }

    func setName(name: String) {
        self.name = name
    }

    func setDescription(description: String) {
        self.description = description
    }

    func asPublic() -> Public {
        return Public(id: self.id, name: self.name, description: self.description)
    }
}
