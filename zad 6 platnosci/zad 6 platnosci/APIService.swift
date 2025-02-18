

import Foundation

class PaymentService {
    
    static let shared = PaymentService()
    
    func processPayment(payment: PaymentRequest, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/payment") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(payment)
            request.httpBody = data
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Brak odpowiedzi od serwera."])))
                return
            }
            
            do {
                // Ensure the response is a valid JSON and decode it
                let decoder = JSONDecoder()
                let response = try decoder.decode(PaymentResponse.self, from: data)
                completion(.success(response.message))
            } catch {
                // If there's an issue decoding, print the raw data to help debug
                print("Error decoding response: \(error.localizedDescription)")
                print("Raw response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}


struct PaymentRequest: Codable {
    let cardNumber: String
    let expiryDate: String
    let cvv: String
}

struct PaymentResponse: Codable {
    let message: String
}
