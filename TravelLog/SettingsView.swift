import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = false
    
    var body: some View {
        Form {
            Section {
                Button("Enable Notifications") {
                    NotificationManager.shared.requestAuthorization()
                    self.notificationsEnabled = true
                }
                .disabled(notificationsEnabled)
                .opacity(notificationsEnabled ? 0.5 : 1)
                .alert(isPresented: $notificationsEnabled) {
                    Alert(title: Text("Notifications"), message: Text("Notifications have been enabled!"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}
