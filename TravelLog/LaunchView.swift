//
//  LaunchView.swift
//  TravelLog
//
//  Created by Yash Somkuwar on 26/08/23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var isactive: Bool = false
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("Travelog")
                .font(.largeTitle)
                .padding(.bottom, 20)
            Image(systemName: "airplane.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .opacity(isactive ? 1.0 : 0.0)
            Text("Your travel diary.")
                            .font(.subheadline)
        }
        .padding()
        .onAppear(){
            withAnimation(.easeInOut(duration: 1.5)){
                isactive = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                self.viewModel.didShowLaunchScreen = true
            }
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

class AppViewModel: ObservableObject {
    @Published var didShowLaunchScreen: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var trips: [Trip] = []
}


