import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Category: Model, Content {
    static let schema = "categories"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "description")
    var description: String?


    init() { }

    init(id: UUID?, name: String, description: String?) {
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
}
