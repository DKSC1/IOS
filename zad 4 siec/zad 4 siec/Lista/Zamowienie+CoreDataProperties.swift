//
//  Zamowienie+CoreDataProperties.swift
//  zad 4 siec
//
//  Created by user270910 on 2/13/25.
//
//

import Foundation
import CoreData


extension Zamowienie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Zamowienie> {
        return NSFetchRequest<Zamowienie>(entityName: "Zamowienie")
    }

    @NSManaged public var id: String?
    @NSManaged public var data: Date?
    @NSManaged public var produkty: NSSet?

}

// MARK: Generated accessors for produkty
extension Zamowienie {

    @objc(addProduktyObject:)
    @NSManaged public func addToProdukty(_ value: Produkt)

    @objc(removeProduktyObject:)
    @NSManaged public func removeFromProdukty(_ value: Produkt)

    @objc(addProdukty:)
    @NSManaged public func addToProdukty(_ values: NSSet)

    @objc(removeProdukty:)
    @NSManaged public func removeFromProdukty(_ values: NSSet)

}

extension Zamowienie : Identifiable {

}
