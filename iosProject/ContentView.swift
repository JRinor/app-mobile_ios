import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Image("logo-noir-nobackground")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(15)
                    .shadow(color: .white, radius: 10)
                    .padding(.top, 50)
                
                Spacer()
                
                HStack(spacing: 40) {
                    VStack(spacing: 15) {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                        NavigationLink(destination: LocalisationView()) {
                            Text("IP Finder")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.blue.opacity(0.5))
                                .cornerRadius(10)
                        }
                    }
                    VStack(spacing: 15) {
                        Image(systemName: "repeat.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.green)
                        NavigationLink(destination: TranslateView()) {
                            Text("Traduction")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.green.opacity(0.5))
                                .cornerRadius(10)
                        }
                    }
                    VStack(spacing: 15) {
                        Image(systemName: "phone.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.purple)
                        NavigationLink(destination: VeriphoneView()) {
                            Text("Veriphone")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.purple.opacity(0.5))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("Accueil")
            .foregroundColor(.white)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
