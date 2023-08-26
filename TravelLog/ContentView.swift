import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Travelog")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            Image(systemName: "airplane.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Your travel diary.")
                .font(.subheadline)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
