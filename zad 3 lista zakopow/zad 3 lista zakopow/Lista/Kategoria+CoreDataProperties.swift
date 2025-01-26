//
//  Kategoria+CoreDataProperties.swift
//  zad 3 lista zakopow
//
//  Created by user270910 on 1/20/25.
//
//

import Foundation
import CoreData


extension Kategoria {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kategoria> {
        return NSFetchRequest<Kategoria>(entityName: "Kategoria")
    }

    @NSManaged public var nazwa: String?
    @NSManaged public var produkty: NSSet?

}

// MARK: Generated accessors for produkty
extension Kategoria {

    @objc(addProduktyObject:)
    @NSManaged public func addToProdukty(_ value: Produkt)

    @objc(removeProduktyObject:)
    @NSManaged public func removeFromProdukty(_ value: Produkt)

    @objc(addProdukty:)
    @NSManaged public func addToProdukty(_ values: NSSet)

    @objc(removeProdukty:)
    @NSManaged public func removeFromProdukty(_ values: NSSet)

}

extension Kategoria : Identifiable {

}
