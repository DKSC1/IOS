import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    @State private var isLoggedIn = false
    
    let url = URL(string: "http://localhost:3000")!

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                login()
            }) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Text(message)
                .foregroundColor(.red)
                .padding()

            
            NavigationLink(destination: RegisterView()) {
                Text("Register")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }

    func login() {
        let loginData = ["username": username, "password": password]
        performRequest(endpoint: "/login", data: loginData)
    }
    
    func performRequest(endpoint: String, data: [String: String]) {
        var request = URLRequest(url: url.appendingPathComponent(endpoint))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    message = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            if let data = data, let responseMessage = try? JSONDecoder().decode([String: String].self, from: data) {
                DispatchQueue.main.async {
                    if let msg = responseMessage["message"] {
                        message = msg
                        
                        if msg == "Login successful" {
                            isLoggedIn = true
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
