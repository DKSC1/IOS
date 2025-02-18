import SwiftUI

struct PaymentForm: View {
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var message = ""
    @State private var connectionMessage = ""  // Dodajemy zmienną do wyświetlania komunikatu o połączeniu
    
    var body: some View {
        VStack {
            TextField("Card Number", text: $cardNumber)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Expiry Date (MM/YY)", text: $expiryDate)
                .padding()
                .keyboardType(.numbersAndPunctuation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("CVV", text: $cvv)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Submit Payment") {
                submitPayment()
            }
            .padding()
            
            // Wyświetlanie komunikatu o stanie płatności
            Text(message)
                .padding()
                .foregroundColor(.green)
            
            // Wyświetlanie komunikatu o połączeniu z serwerem
            Text(connectionMessage)
                .padding()
                .foregroundColor(.blue)
                .onAppear {
                    checkServerConnection()  // Sprawdzamy połączenie z serwerem, gdy ekran się załaduje
                }
        }
        .padding()
    }
    
    func submitPayment() {
        guard let url = URL(string: "http://localhost:3000/payment") else { return }
        
        let parameters = [
            "cardNumber": cardNumber,
            "expiryDate": expiryDate,
            "cvv": cvv
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON data: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.message = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.message = "No data received"
                }
                return
            }
            
            if let responseString = try? JSONDecoder().decode([String: String].self, from: data),
               let message = responseString["message"] {
                DispatchQueue.main.async {
                    self.message = message
                }
            }
        }
        
        task.resume()
    }
    
    // Funkcja do sprawdzenia połączenia z serwerem
    func checkServerConnection() {
        guard let url = URL(string: "http://localhost:3000/check-connection") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.connectionMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.connectionMessage = "No data received"
                }
                return
            }
            
            if let responseString = try? JSONDecoder().decode([String: String].self, from: data),
               let message = responseString["message"] {
                DispatchQueue.main.async {
                    self.connectionMessage = message  // Wyświetlamy komunikat z serwera
                }
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    var body: some View {
        PaymentForm()
    }
}
	
