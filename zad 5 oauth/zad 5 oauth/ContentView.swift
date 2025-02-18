import SwiftUI

struct ContentView: View {
    @State private var isRegistering = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isRegistering {
                    RegisterView()
                } else {
                    LoginView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    ContentView()
    
}
