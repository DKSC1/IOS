import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var cartModel: CartModel
    @FetchRequest(
        entity: Produkt.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Produkt.nazwa, ascending: true)]
    ) private var produkty: FetchedResults<Produkt>


    var body: some View {
        NavigationView {
            List {
                ForEach(produkty) { produkt in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(produkt.nazwa ?? "Nieznany produkt")
                                .font(.headline)
                            Text("Cena: \(produkt.cena?.doubleValue ?? 0.0, specifier: "%.2f") zł")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                            cartModel.dodajDoKoszyka(produkt)
                        }) {
                            Image(systemName: "cart.badge.plus")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle("Produkty")
        }
    }
    
}
