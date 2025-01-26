import SwiftUI

struct ProductDetailView: View {
    let produkt: Produkt

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(produkt.nazwa ?? "Brak nazwy")
                .font(.largeTitle)
                .bold()

            Text("Cena: \(produkt.cena?.doubleValue ?? 0.0, specifier: "%.2f") zł")
                .font(.title2)

            Text(produkt.opis ?? "Brak opisu")
                .font(.body)
                .padding(.top)

            Spacer()
        }
        .padding()
        .navigationTitle("Szczegóły produktu")
    }
}



