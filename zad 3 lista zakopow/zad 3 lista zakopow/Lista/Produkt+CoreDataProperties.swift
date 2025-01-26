//
//  Produkt+CoreDataProperties.swift
//  zad 3 lista zakopow
//
//  Created by user270910 on 1/20/25.
//
//

import Foundation
import CoreData


extension Produkt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Produkt> {
        return NSFetchRequest<Produkt>(entityName: "Produkt")
    }
    @NSManaged public var opis: String?
    @NSManaged public var nazwa: String?
    @NSManaged public var cena: NSDecimalNumber?
    @NSManaged public var kategoria: Kategoria?

}

extension Produkt : Identifiable {

}
