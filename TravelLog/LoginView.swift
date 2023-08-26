import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var showSettings = false
    @State private var showingAlert = false // for showing an alert on a failed login
    
    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "airplane.circle.fill") // Replace this with your app logo
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(Color.blue.opacity(0.7))
            
            Text("Welcome to Travelog")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    TextField("Enter Username", text: $username)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                    SecureField("Enter Password", text: $password)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            
            Button("Login") {
                handleLogin()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
            
        }
        .padding(.horizontal, 20)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.showSettings.toggle()
                        }) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    )
                    .sheet(isPresented: $showSettings) {
                        SettingsView()  // Your SettingsView
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Login Failed"), message: Text("Incorrect username or password"), dismissButton: .default(Text("Try Again")))
                    }
        
    }
    
    func handleLogin() {
        if username == "user" && password == "password" {
            viewModel.isLoggedIn = true
        } else {
            // Handle failed login by showing an alert
            showingAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView().environmentObject(AppViewModel())
        }
    }
}
