import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    
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
                register()
            }) {
                Text("Register")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Text(message)
                .foregroundColor(.red)
                .padding()
            
            
            NavigationLink(destination: LoginView()) {
                Text("Already have an account? Login")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }

    func register() {
        let registerData = ["username": username, "password": password]
        performRequest(endpoint: "/register", data: registerData)
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
                     
                        if msg == "User registered successfully" {
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                               
                                message = ""
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
