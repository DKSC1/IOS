import SwiftUI

struct CashOnDeliveryView: View {
    @State private var fullName = ""
    @State private var address = ""
    @State private var amount = ""
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Płatność za pobraniem")
                .font(.largeTitle)

            TextField("Imię i nazwisko", text: $fullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Adres dostawy", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Kwota", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            Button("Zamów z płatnością za pobraniem") {
                submitPayment()
            }
            .buttonStyle()

            Text(message)
                .foregroundColor(.green)
        }
        .padding()
    }
    
    func submitPayment() {
        if !fullName.isEmpty && !address.isEmpty && !amount.isEmpty {
            message = "Zamówienie za pobraniem złożone"
        } else {
            message = "Proszę wypełnić wszystkie pola"
        }
    }
}
