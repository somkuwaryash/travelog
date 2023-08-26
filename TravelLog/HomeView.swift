import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showAddTrip: Bool = false
    @State private var selectedTrip: Trip?
    


    var body: some View {
        NavigationView {
            ZStack {

                List {
                    ForEach(viewModel.trips) { trip in
                        TripCardView(trip: trip)
                            .background(
                                NavigationLink("", destination: TripDetailView(selectedTrip: $selectedTrip).environmentObject(viewModel))
                                    .opacity(0)
                                    .buttonStyle(PlainButtonStyle())
                            )
                            .onTapGesture {
                                selectedTrip = trip
                            }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .background(Color.clear)
                .navigationTitle("My Trips")
            }
            
            .overlay(
                // Floating Action Button for Adding Trips
                Button(action: {
                    showAddTrip = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                        .shadow(color: .gray, radius: 2, x: 1, y: 2)
                }
                    .padding(.horizontal, 20)
                .padding(.bottom, 20),
                alignment: .bottomTrailing
            )
            .sheet(isPresented: $showAddTrip) {
                AddTripView(showAddTrip: $showAddTrip).environmentObject(viewModel)
            }
        }
    }
}

struct TripCardView: View {
    var trip: Trip

    var body: some View {
        HStack {
            Image(systemName: "airplane.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(trip.name)
                    .font(.headline)
                Text(trip.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical)
    }
}

struct Trip: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var location: String
    var startDate: Date
    var endDate: Date
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppViewModel())
    }
}
