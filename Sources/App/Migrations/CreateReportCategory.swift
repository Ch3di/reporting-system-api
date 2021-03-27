import Fluent

struct CreateReportCategory: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ReportCategory.schema)
                .id()
                .field(ReportCategory.FieldKeys.report, .uuid)
                .field(ReportCategory.FieldKeys.category, .uuid)
                .foreignKey(ReportCategory.FieldKeys.report, references: Report.schema, .id, onUpdate: .cascade)
                .foreignKey(ReportCategory.FieldKeys.category, references: Category.schema, .id, onUpdate: .cascade)
                // .unique(on: "report_id", "category_id")
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ReportCategory.schema).delete()
    }
}

// import Foundation
// import Fluent

// struct CreateContactMailingList: Migration {
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        database.eventLoop.flatten([
//            database.schema(ContactMailingList.schema)
//                    .id()
//                    .field(ContactMailingList.FieldKeys.contact, .uuid, .required)
//                    .field(ContactMailingList.FieldKeys.mailingList, .uuid, .required)
//                    .foreignKey(ContactMailingList.FieldKeys.contact,
//                            references: Contact.schema, .id,
// // onDelete: DatabaseSchema.ForeignKeyAction.setNull,
//                            onUpdate: .cascade)
//                    .foreignKey(ContactMailingList.FieldKeys.mailingList,
//                            references: MailingList.schema, .id,
// // onDelete: DatabaseSchema.ForeignKeyAction.setNull,
//                            onUpdate: .cascade)
//                    .unique(on: ContactMailingList.FieldKeys.contact, ContactMailingList.FieldKeys.mailingList)
//                    .field(ContactMailingList.FieldKeys.createdAt, .datetime)
//                    .field(ContactMailingList.FieldKeys.updatedAt, .datetime)
//                    .field(ContactMailingList.FieldKeys.deletedAt, .datetime)
//                    .create(),
//        ])
//    }

//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        database.eventLoop.flatten([
//            database.schema(ContactMailingList.schema).delete(),
//        ])
//    }
// }


// import Fluent
// import Vapor
// import Foundation


// final class ContactMailingList: Model, Content {

//    static var tableName = "contact_mailing_lists"

//    struct FieldKeys {
//        static var contact: FieldKey { "contact_id" }
//        static var mailingList: FieldKey { "mailing_list_id" }

//        static var createdAt: FieldKey { "created_at" }
//        static var updatedAt: FieldKey { "updated_at" }
//        static var deletedAt: FieldKey { "deleted_at" }
//    }

//    static let schema = tableName

//    @ID(key: .id) var id: UUID?
//    @Parent(key: FieldKeys.contact) var contact: Contact
//    @Parent(key: FieldKeys.mailingList) var mailingList: MailingList

//    @Timestamp(key: FieldKeys.createdAt, on: .create) var createdAt: Date?
//    @Timestamp(key: FieldKeys.updatedAt, on: .update) var updatedAt: Date?
//    @Timestamp(key: FieldKeys.deletedAt, on: .delete) var deletedAt: Date?

//    init() { }

//    init(id: UUID? = nil, contact: Contact, mailingList: MailingList) throws {
//        self.id = id
//        self.$contact.id = try contact.requireID()
//        self.$mailingList.id = try mailingList.requireID()
//    }
// }