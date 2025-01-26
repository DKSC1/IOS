import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartModel: CartModel

    var body: some View {
        NavigationView {
            VStack {
                if cartModel.produktyWKoszyku.isEmpty {
                    Text("Koszyk jest pusty.")
                        .font(.title)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(cartModel.produktyWKoszyku.keys.sorted(by: { $0.nazwa ?? "" < $1.nazwa ?? "" }), id: \.self) { produkt in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(produkt.nazwa ?? "Nieznany produkt")
                                        .font(.headline)
                                    Text("Cena: \(produkt.cena?.doubleValue ?? 0.0, specifier: "%.2f") zł")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("Ilość: \(cartModel.produktyWKoszyku[produkt] ?? 0)")
                                        .font(.footnote)
                                }
                                Spacer()
                                // Przycisk: Zmniejsz ilość
                                Button(action: {
                                    cartModel.usunJednaSztuke(produkt)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())

                                // Przycisk: Usuń wszystkie sztuki
                                Button(action: {
                                    cartModel.usunWszystkieSztuki(produkt)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Koszyk")
            .toolbar {
                if !cartModel.produktyWKoszyku.isEmpty {
                    Button("Wyczyść koszyk") {
                        cartModel.wyczyscKoszyk()
                    }
                }
            }
        }
    }
}
