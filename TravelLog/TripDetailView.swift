//
//  TripDetailView.swift
//  TravelLog
//
//  Created by Yash Somkuwar on 26/08/23.
//

import SwiftUI

struct TripDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var selectedTrip: Trip?
    
    @State private var showEditView: Bool = false
    
    var body: some View {
        VStack {
            if let trip = selectedTrip {
                Text(trip.name)
                    .font(.largeTitle)
                    .padding()
                
                Text(trip.location)
                    .font(.title)
                
                Spacer().frame(height: 20)
                
                HStack {
                    Text("Start Date:")
                    Spacer()
                    Text("\(trip.startDate, formatter: DateFormatter.shortDate)")
                }
                .padding()
                
                HStack {
                    Text("End Date:")
                    Spacer()
                    Text("\(trip.startDate, formatter:DateFormatter.shortDate)")

                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    showEditView.toggle()
                }) {
                    Text("Edit Trip")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {
                    deleteTrip(trip: trip)
                }) {
                    Text("Delete Trip")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            EditTripView(trip: $selectedTrip).environmentObject(viewModel)
        }
    }
    
    func deleteTrip(trip: Trip) {
        viewModel.trips.removeAll { $0.id == trip.id }
        selectedTrip = nil // This will pop the view
    }
    
}
extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}


//struct TripDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripDetailView().environmentObject(AppViewModel())
//    }
//}

struct TripDetailView_Previews: PreviewProvider {
    // Sample Trip for Preview
    static var sampleTrip = Trip(name: "Sample Trip", location: "Sample Location", startDate: Date(), endDate: Date())
    
    // Sample AppViewModel for Preview
    static var viewModel: AppViewModel = {
        let vm = AppViewModel()
        vm.trips = [sampleTrip]
        return vm
    }()
    
    static var previews: some View {
        TripDetailView(selectedTrip: .constant(sampleTrip))
            .environmentObject(viewModel)
    }
}
