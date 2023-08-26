import SwiftUI

struct EditTripView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var trip: Trip?
    
    @State private var tripName: String = ""
    @State private var tripLocation: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @State private var showingErrorAlert: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    HStack {
                        Image(systemName: "text.badge.plus")
                            .foregroundColor(.gray)
                        TextField("Trip Name", text: $tripName)
                    }
                    .padding(.vertical, 10)
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.gray)
                        TextField("Location", text: $tripLocation)
                    }
                    .padding(.vertical, 10)
                    
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }
            }
            .onAppear(perform: loadTripData)
            .navigationBarTitle("Edit Trip", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    trip = nil
                },
                trailing: Button("Save") {
                    guard !tripName.isEmpty, !tripLocation.isEmpty else {
                        showingErrorAlert = true
                        return
                    }
                    updateTrip()
                }
            )
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all the details."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func loadTripData() {
        if let existingTrip = trip {
            tripName = existingTrip.name
            tripLocation = existingTrip.location
            startDate = existingTrip.startDate
            endDate = existingTrip.endDate
        }
    }
    
    func updateTrip() {
        if let index = viewModel.trips.firstIndex(where: { $0.id == trip?.id }) {
            let updatedTrip = Trip(id: trip!.id, name: tripName, location: tripLocation, startDate: startDate, endDate: endDate)
            viewModel.trips[index] = updatedTrip
            trip = updatedTrip
        }
    }
}

struct EditTripView_Previews: PreviewProvider {
    static var previews: some View {
        EditTripView(trip: .constant(Trip(name: "Sample", location: "Location", startDate: Date(), endDate: Date()))).environmentObject(AppViewModel())
    }
}
