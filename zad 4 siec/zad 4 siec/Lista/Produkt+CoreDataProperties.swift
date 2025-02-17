//
//  Produkt+CoreDataProperties.swift
//  zad 4 siec
//
//  Created by user270910 on 2/13/25.
//
//

import Foundation
import CoreData


extension Produkt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Produkt> {
        return NSFetchRequest<Produkt>(entityName: "Produkt")
    }

    @NSManaged public var cena: NSDecimalNumber?
    @NSManaged public var id: String?
    @NSManaged public var nazwa: String?
    @NSManaged public var opis: String?
    @NSManaged public var kategoria: Kategoria?

}

extension Produkt : Identifiable {

}
