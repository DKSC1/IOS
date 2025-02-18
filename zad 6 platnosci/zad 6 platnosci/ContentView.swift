import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Wybierz metodę płatności")
                    .font(.largeTitle)
                
                NavigationLink(destination: CardPaymentView()) {
                    Text("Płatność kartą")
                        .buttonStyle()
                }
                
                NavigationLink(destination: BlikPaymentView()) {
                    Text("Płatność BLIK")
                        .buttonStyle()
                }

                NavigationLink(destination: PayPalPaymentView()) {
                    Text("Płatność PayPal")
                        .buttonStyle()
                }
                
                NavigationLink(destination: CashOnDeliveryView()) {
                    Text("Płatność za pobraniem")
                        .buttonStyle()
                }
            }
            .padding()
        }
    }
}

// Dodanie stylu dla przycisków
extension View {
    func buttonStyle() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
