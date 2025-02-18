import SwiftUI

struct PayPalPaymentView: View {
    @State private var email = ""
    @State private var amount = ""
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Płatność PayPal")
                .font(.largeTitle)

            TextField("E-mail PayPal", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            TextField("Kwota", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            Button("Zapłać") {
                submitPayment()
            }
            .buttonStyle()

            Text(message)
                .foregroundColor(.green)
        }
        .padding()
    }
    
    func submitPayment() {
        if email.contains("@") && !amount.isEmpty {
            message = "Płatność PayPal zaakceptowana"
        } else {
            message = "Niepoprawne dane PayPal"
        }
    }
}
