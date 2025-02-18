import Foundation

struct PaymentService {
    static func processPayment(_ paymentData: [String: Any], completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://localhost:3000/pay") else {
            completion(false, "Błąd URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paymentData, options: [])
        } catch {
            completion(false, "Błąd przetwarzania danych")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, "Błąd: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion(false, "Brak odpowiedzi")
                return
            }

            if httpResponse.statusCode == 200 {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = jsonResponse["message"] as? String {
                    completion(true, message)
                } else {
                    completion(true, "Płatność zaakceptowana")
                }
            } else {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = jsonResponse["message"] as? String {
                    completion(false, message)
                } else {
                    completion(false, "Nieznany błąd")
                }
            }
        }

        task.resume()
    }
}
