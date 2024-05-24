import SwiftUI
import Foundation
import Combine

struct VeriphoneView: View {
    @StateObject private var viewModel = PhoneInfoControllerModel()
    @State private var usernum: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "phone.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.purple)
                .padding(.top, 50)
            
            Text("Veriphone")
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding(.top, 40)
            
            HStack {
                TextField("Entrez un numéro de téléphone :", text: $usernum)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                
                Button(action: {
                    viewModel.fetchPhoneInfos(for: usernum)
                    self.usernum = ""
                }) {
                    Text("Rechercher")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(minWidth: 50)
                        .background(Color.purple)
                        .cornerRadius(10)
                        .shadow(color: .purple, radius: 10, x: 0, y: 5)
                }
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            if let phoneInfo = viewModel.phoneInfos {
                VStack(spacing: 10) {
                    Text("Numéro de téléphone valide !")
                        .foregroundColor(.purple)
                        .bold()
                        .padding(.bottom, 10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Numéro:")
                            Text("Pays:")
                            Text("Type:")
                            Text("Opérateur:")
                        }
                        .foregroundColor(.white)
                        .bold()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(phoneInfo.phone)
                            Text(phoneInfo.country)
                            Text(phoneInfo.phone_type)
                            Text(phoneInfo.carrier)
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.purple, lineWidth: 2)
                            )
                    )
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle("Veriphone")
        .navigationBarTitleDisplayMode(.inline)
    }
}
