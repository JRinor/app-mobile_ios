import SwiftUI
import Foundation
import Combine

struct LocalisationView: View {
    @StateObject private var viewModel = IPInfoViewModel()
    @State private var userip: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "location.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)
                .padding(.top, 50)
            
            Text("IP Finder")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            HStack {
                TextField("Entrez une adresse IP", text: $userip)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                
                Button(action: {
                    viewModel.fetchIPInfo(for: userip)
                    self.userip = ""
                }) {
                    Text("Rechercher")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(minWidth: 50)
                        .background(.blue)
                        .cornerRadius(10)
                        .shadow(color: .blue, radius: 10, x: 0, y: 5)
                }
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            if let ipInfo = viewModel.ipInfo {
                VStack(spacing: 10) {
                    Text("Adresse IP localisée avec succès !")
                        .foregroundColor(.blue)
                        .bold()
                        .padding(.bottom, 10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("IP:")
                            Text("Pays:")
                            Text("Ville:")
                        }
                        .foregroundColor(.white)
                        .bold()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(ipInfo.ip)
                            Text(ipInfo.country_name)
                            Text(ipInfo.city_name)
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black.opacity(0.8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    )
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle("Localisation")
        .navigationBarTitleDisplayMode(.inline)
    }
}
