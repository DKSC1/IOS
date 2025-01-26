import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "zad_3_lista_zakopow")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        clearData(context: container.viewContext)
        loadFixtures(context: container.viewContext)
    }
    

    func loadFixtures(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Produkt> = Produkt.fetchRequest()

        do {
            let count = try context.count(for: request)
            if count > 0 {
                print("Dane przykładowe już istnieją.")
                return
            }
        } catch {
            print("Błąd podczas sprawdzania danych: \(error)")
            return
        }

        let produkt1 = Produkt(context: context)
        produkt1.nazwa = "Laptop"
        produkt1.cena = NSDecimalNumber(value: 5000.00)
        produkt1.opis = "Nowoczesny laptop szybki"

        

        let produkt2 = Produkt(context: context)
        produkt2.nazwa = "Smartfon"
        produkt2.cena = NSDecimalNumber(value: 3000.00)
        produkt2.opis = "Telefon z dobrym aparatem"

        let produkt3 = Produkt(context: context)
        produkt3.nazwa = "Kurtka zimowa"
        produkt3.cena = NSDecimalNumber(value: 250.00)
        produkt3.opis = "Kurtka zimowa ciepla"
        

        let produkt4 = Produkt(context: context)
        produkt4.nazwa = "Słuchawki"
        produkt4.cena = NSDecimalNumber(value: 150.00)
        produkt4.opis = "Sluchawki dobry dzwiek"

        do {
            try context.save()
            print("Dane przykładowe załadowane.")
        } catch {
            print("Nie udało się zapisać danych przykładowych: \(error)")
        }
    }
    func clearData(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Produkt.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Wyczyszczono wszystkie dane.")
        } catch {
            print("Błąd podczas czyszczenia danych: \(error)")
        }
    }


}
