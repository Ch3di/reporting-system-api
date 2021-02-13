import Fluent
import FluentPostgresDriver
import Foundation
import Vapor

struct AddCategories: Migration {
    let categories: [String: String] = [
        "personal attack": "personal attacks often involve someone making damaging remarks relating to somebody’s lifestyle or choices. These types of attack can include comments that question a person’s intelligence, values, integrity, motivations or decisions.",
        "fake profile": "a fake profile is the representation of a person, organization or company that does not truly exist, on social media. Often these accounts use names and identities that not only look real but are designed to get closer access to specific people and their target audience.",
        "harassment": "harassment is a form of discrimination. It includes any unwanted physical or verbal behaviour that offends or humiliates you",
        "hacked account": "someone has gotten into your account somehow, often by stealing your password or your email password.",
        "term violation": "breaks or acts against the terms and conditions.",
        "impersonation": "someone who imitates or copies your behavior or actions.",
        "prostitution": "practice or occupation of engaging in sexual activity with someone for payment.",
        "racism": "prejudice, discrimination, or antagonism by an individual, community, or institution against a person or people on the basis of their membership of a particular racial or ethnic group.",
        "sexism": "prejudice or discrimination based on sex or gender",
        "terrorism recruitment": "hiring candidates for a terrorism actions",
        "scams": "deceive and defraud people",
        "unauthorized sales": "the promotion or sale of counterfeits, such as goods that copy the trademark (name or logo) and/or distinctive features of another company's products to imitate a genuine product",
        "intellectual property": "any breach of intellectual property rights. copied or otherwise exploited without having the proper permission from a person who owns those rights.",
        "personal threat": "a person who is behaving in an aggressive, threatening or violent manner, and may or may not be armed."
    ]

    func prepare(on database: Database) -> EventLoopFuture<Void> {
         let futures = categories.map { (name, description) -> EventLoopFuture<Void> in
            let category = Category()
            category.setName(name: name)
            category.setDescription(description: description)
            return category.save(on: database).transform(to: ())
        }
        return futures.flatten(on: database.eventLoop)
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        let futures = categories.map { (name, description) -> EventLoopFuture<Void> in
            Category.query(on: database).filter(\.$name == name).delete()
        }
        return futures.flatten(on: database.eventLoop)
    }
}
