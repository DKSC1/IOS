import SwiftUI

struct BlikPaymentView: View {
    @State private var blikCode = ""
    @State private var amount = ""
    @State private var message = ""
    @State private var isSuccess = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Płatność BLIK")
                .font(.largeTitle)

            TextField("Kod BLIK", text: $blikCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            TextField("Kwota", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            Button("Zapłać") {
                submitPayment()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            Text(message)
                .foregroundColor(isSuccess ? .green : .red)
        }
        .padding()
    }
    
    func submitPayment() {
        if blikCode.count == 6 {
            message = "Płatność BLIK zaakceptowana"
            isSuccess = true
        } else {
            message = "Niepoprawny kod BLIK"
            isSuccess = false
        }
    }
}
