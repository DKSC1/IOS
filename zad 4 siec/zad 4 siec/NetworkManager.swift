import Foundation
import CoreData


struct APIResponse: Codable {
    let kategorie: [KategoriaJSON]
    let produkty: [ProduktJSON]
    let zamowienia: [ZamowienieJSON]
}

struct KategoriaJSON: Codable {
    let id: String
    let nazwa: String
}

struct ProduktJSON: Codable {
    let id: String
    let nazwa: String
    let cena: Decimal
    let kategoria_id: String
}

struct ZamowienieJSON: Codable {
    let id: String
    let data: String
    let produkty: [ProduktZamowienieJSON]
}

struct ProduktZamowienieJSON: Codable {
    let id: String
    let ilosc: Int
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = URL(string: "http://localhost:3000/data")!
    
    func fetchAllData(context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
        URLSession.shared.dataTask(with: baseUrl) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(error) }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(APIResponse.self, from: data)
                
                
                self.saveAllData(
                    categories: decodedData.kategorie,
                    products: decodedData.produkty,
                    orders: decodedData.zamowienia,
                    context: context
                )
                
                DispatchQueue.main.async { completion(nil) }
            } catch {
                DispatchQueue.main.async { completion(error) }
                print("Błąd dekodowania: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func saveAllData(
        categories: [KategoriaJSON],
        products: [ProduktJSON],
        orders: [ZamowienieJSON],
        context: NSManagedObjectContext
    ) {
        context.perform {
            do {
               
                for category in categories {
                    let fetchRequest: NSFetchRequest<Kategoria> = Kategoria.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", category.id)
                    
                    let existingCategory = try context.fetch(fetchRequest).first ?? Kategoria(context: context)
                    existingCategory.id = category.id
                    existingCategory.nazwa = category.nazwa
                }
                
                for product in products {
                    let fetchRequest: NSFetchRequest<Produkt> = Produkt.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", product.id)
                    
                    let existingProduct = try context.fetch(fetchRequest).first ?? Produkt(context: context)
                    existingProduct.id = product.id
                    existingProduct.nazwa = product.nazwa
                    existingProduct.cena = NSDecimalNumber(decimal: product.cena)
                    
                    let categoryFetch: NSFetchRequest<Kategoria> = Kategoria.fetchRequest()
                    categoryFetch.predicate = NSPredicate(format: "id == %@", product.kategoria_id)
                    if let category = try context.fetch(categoryFetch).first {
                        existingProduct.kategoria = category
                    }
                }
                
                for order in orders {
                    let fetchRequest: NSFetchRequest<Zamowienie> = Zamowienie.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", order.id)
                    
                    let existingOrder = try context.fetch(fetchRequest).first ?? Zamowienie(context: context)
                    existingOrder.id = order.id
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    existingOrder.data = dateFormatter.date(from: order.data) ?? Date()
                    
                    
                    var produktySet = Set<Produkt>()
                    for produkt in order.produkty {
                        let productFetch: NSFetchRequest<Produkt> = Produkt.fetchRequest()
                        productFetch.predicate = NSPredicate(format: "id == %@", produkt.id)
                        if let product = try context.fetch(productFetch).first {
                            produktySet.insert(product)
                        }
                    }
                    existingOrder.produkty = produktySet as NSSet
                }
                
                try context.save()
                print("Wszystkie dane zaktualizowane")
            } catch {
                print("Błąd zapisu danych: \(error)")
            }
        }
    }
    
    func startDataCheckTimer(context: NSManagedObjectContext) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.fetchAllData(context: context) { error in
                if let error = error {
                    print("Błąd aktualizacji danych: \(error.localizedDescription)")
                }
            }
        }
    }
}
