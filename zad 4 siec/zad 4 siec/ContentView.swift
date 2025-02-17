import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            SplitCategoriesProductsView()
                .tabItem {
                    Label("Sklep", systemImage: "cart")
                }
            
            NavigationView {
                OrdersListView()
            }
            .tabItem {
                Label("Zamówienia", systemImage: "tray.full")
            }
        }
    }
}

struct SplitCategoriesProductsView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Kategoria.nazwa, ascending: true)],
        animation: .default
    ) private var categories: FetchedResults<Kategoria>
    
    @State private var selectedCategory: Kategoria?

    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
           
                List(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        HStack {
                            Text(category.nazwa ?? "Brak nazwy")
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedCategory == category {
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    .listRowBackground(selectedCategory == category ? Color(.systemGray5) : Color.clear)
                }
                .frame(width: 200)
                .navigationTitle("Kategorie")

               
                if let selectedCategory = selectedCategory {
                    CategoryProductsView(category: selectedCategory)
                } else {
                    VStack {
                        Text("Wybierz kategorię z listy po lewej")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

struct CategoryProductsView: View {
    let category: Kategoria
    
    @FetchRequest private var products: FetchedResults<Produkt>
    
    init(category: Kategoria) {
        self.category = category
        _products = FetchRequest(
            entity: Produkt.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Produkt.nazwa, ascending: true)],
            predicate: NSPredicate(format: "kategoria == %@", category)
        )
    }

    var body: some View {
        VStack {
            List(products) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.nazwa ?? "Brak nazwy")
                            .font(.headline)
                        Text("Cena: \(product.cena?.stringValue ?? "0.00") zł")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .navigationTitle(category.nazwa ?? "Produkty")
    }
}


struct OrdersListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Zamowienie.data, ascending: false)],
        animation: .default
    )
    private var orders: FetchedResults<Zamowienie>

    var body: some View {
        List(orders) { order in
            VStack(alignment: .leading) {
                Text("Zamówienie #\(order.id?.prefix(6) ?? "000000")")
                    .font(.headline)
                
                Text("Produkty:")
                    .font(.subheadline)
                    .padding(.top, 4)
                
                ForEach(order.produkty?.allObjects as? [Produkt] ?? [], id: \.self) { produkt in
                    Text("- \(produkt.nazwa ?? "Nieznany produkt")")
                        .font(.caption)
                }
                
                Text("Data: \(order.data ?? Date(), formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Zamówienia")
    }
}

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "zł"
    formatter.minimumFractionDigits = 2
    return formatter
}()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()


#Preview {
    ContentView()
}
