import SwiftUI

struct CardPaymentView: View {
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var amount = ""
    @State private var message = ""
    @State private var isSuccess = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Płatność kartą")
                .font(.largeTitle)
            
            TextField("Numer karty", text: $cardNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            TextField("Data ważności (MM/YY)", text: $expiryDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            SecureField("CVV", text: $cvv)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            TextField("Kwota", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            Button("Zapłać") {
                submitPayment()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Text(message)
                .foregroundColor(isSuccess ? .green : .red)
        }
        .padding()
    }
    
    func submitPayment() {
        let paymentData: [String: Any] = [
            "cardNumber": cardNumber,
            "expiryDate": expiryDate,
            "cvv": cvv,
            "amount": amount
        ]

        PaymentService.processPayment(paymentData) { success, responseMessage in
            DispatchQueue.main.async {
                self.isSuccess = success
                self.message = responseMessage
            }
        }
    }
}
