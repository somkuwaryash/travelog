import SwiftUI

struct AddTripView: View {
    @Binding var showAddTrip: Bool
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var tripName: String = ""
    @State private var tripLocation: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    // Gradient for the background
    let gradientBackground = LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details").font(.headline)) {
                    
                    HStack {
                        Image(systemName: "text.badge.plus")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                            .padding(.trailing, 10)
                        TextField("Trip Name", text: $tripName)
                            .placeholder(when: tripName.isEmpty) {
                                Text("Trip Name").foregroundColor(.gray)
                            }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))

                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                            .padding(.trailing, 10)
                        TextField("Location", text: $tripLocation)
                            .placeholder(when: tripLocation.isEmpty) {
                                Text("Location").foregroundColor(.gray)
                            }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                    
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
            }
            .listStyle(GroupedListStyle())
            .background(gradientBackground.ignoresSafeArea())
            .navigationBarTitle("Add Trip", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    showAddTrip = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                },
                trailing: Button(action: saveTrip) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            )
        }
    }
    
    func saveTrip() {
        let newTrip = Trip(name: tripName, location: tripLocation, startDate: startDate, endDate: endDate)
        viewModel.trips.append(newTrip)
        showAddTrip = false
        // Optional: Provide haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// A custom modifier for TextField placeholders
extension View {
    func placeholder<T: View>(when shouldShow: Bool, placeholder: () -> T) -> some View {
        ZStack(alignment: .leading) {
            self
            if shouldShow { placeholder() }
        }
    }
}

struct AddTripView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripView(showAddTrip: .constant(true)).environmentObject(AppViewModel())
    }
}
