import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "zad_4_siec")
        
     
        let description = container.persistentStoreDescriptions.first!
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        
        if let storeURL = description.url {
            let fileManager = FileManager.default
            try? fileManager.removeItem(at: storeURL)
        }


        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        
        NetworkManager.shared.startDataCheckTimer(context: container.viewContext)
    }

    
    func saveCategoryAndProductsLocally(categories: [KategoriaJSON], products: [ProduktJSON], context: NSManagedObjectContext) {
        context.perform {
            do {
               
                for category in categories {
                    if let existingCategory = self.getCategoryById(categoryId: category.id, context: context) {
                       
                        existingCategory.nazwa = category.nazwa
                    } else {
                        
                        let categoryObject = Kategoria(context: context)
                        categoryObject.id = category.id
                        categoryObject.nazwa = category.nazwa
                    }
                }

               
                for product in products {
                    if let existingProduct = self.getProductById(productId: product.id, context: context) {
                       
                        existingProduct.nazwa = product.nazwa
                        existingProduct.cena = NSDecimalNumber(decimal: product.cena)
                       
                        if let category = self.getCategoryById(categoryId: product.kategoria_id, context: context) {
                            existingProduct.kategoria = category
                        }
                    } else {
                        
                        let productObject = Produkt(context: context)
                        productObject.id = product.id
                        productObject.nazwa = product.nazwa
                        productObject.cena = NSDecimalNumber(decimal: product.cena)

                        
                        if let category = self.getCategoryById(categoryId: product.kategoria_id, context: context) {
                            productObject.kategoria = category
                        }
                    }
                }

                try context.save()
            } catch {
                print("Błąd zapisu danych lokalnych: \(error)")
            }
        }
    }

    private func getCategoryById(categoryId: String, context: NSManagedObjectContext) -> Kategoria? {
        let fetchRequest: NSFetchRequest<Kategoria> = Kategoria.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", categoryId)
        do {
            let categories = try context.fetch(fetchRequest)
            return categories.first
        } catch {
            print("Błąd pobierania kategorii: \(error)")
            return nil
        }
    }

    private func getProductById(productId: String, context: NSManagedObjectContext) -> Produkt? {
        let fetchRequest: NSFetchRequest<Produkt> = Produkt.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", productId)
        do {
            let products = try context.fetch(fetchRequest)
            return products.first
        } catch {
            print("Błąd pobierania produktu: \(error)")
            return nil
        }
    }
    
    
}
