import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var cartModel = CartModel() // Model koszyka
    
    @FetchRequest(
        entity: Produkt.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Produkt.nazwa, ascending: true)]
    ) var produkty: FetchedResults<Produkt>

    var body: some View {
        TabView {
            NavigationView {
                List(produkty, id: \.self) { produkt in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(produkt.nazwa ?? "Brak nazwy")
                                .font(.headline)
                            Text("Cena: \(produkt.cena?.doubleValue ?? 0.0, specifier: "%.2f") zł")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack {
                            // Przycisk szczegółów produktu
                            NavigationLink(destination: ProductDetailView(produkt: produkt)) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Użyj BorderlessButtonStyle w List

                            // Przycisk dodawania do koszyka
                            Button(action: {
                                cartModel.dodajDoKoszyka(produkt)
                            }) {
                                Image(systemName: "cart.badge.plus")
                                    .foregroundColor(.blue)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Użyj BorderlessButtonStyle w List
                        }
                        .padding(.leading, 10) // Odstęp między przyciskami a tekstem
                    }
                    .padding(.vertical, 5)
                }
                .navigationTitle("Produkty")
            }
            .tabItem {
                Label("Produkty", systemImage: "list.bullet")
            }

            CartView()
                .tabItem {
                    Label("Koszyk", systemImage: "cart")
                }
        }
        .environmentObject(cartModel) // Udostępnij koszyk w całej aplikacji
    }
}

#Preview {
    ContentView()
}
