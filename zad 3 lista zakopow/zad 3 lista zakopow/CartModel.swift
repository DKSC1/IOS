import Foundation

class CartModel: ObservableObject {
    @Published var produktyWKoszyku: [Produkt: Int] = [:]

    // Dodawanie produktu do koszyka
    func dodajDoKoszyka(_ produkt: Produkt) {
        if let ilosc = produktyWKoszyku[produkt] {
            produktyWKoszyku[produkt] = ilosc + 1
        } else {
            produktyWKoszyku[produkt] = 1
        }
    }

    // Usuwanie jednej sztuki produktu z koszyka
    func usunJednaSztuke(_ produkt: Produkt) {
        guard let ilosc = produktyWKoszyku[produkt], ilosc > 0 else { return }
        if ilosc == 1 {
            produktyWKoszyku.removeValue(forKey: produkt)
        } else {
            produktyWKoszyku[produkt] = ilosc - 1
        }
    }

    // Usuwanie wszystkich sztuk produktu z koszyka
    func usunWszystkieSztuki(_ produkt: Produkt) {
        produktyWKoszyku.removeValue(forKey: produkt)
    }

    // Czyszczenie całego koszyka
    func wyczyscKoszyk() {
        produktyWKoszyku.removeAll()
    }
}
