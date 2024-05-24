import SwiftUI

struct TranslateView: View {
    @State private var textToTranslate = ""
    @State private var translatedText = ""
    @State private var sourceLanguage = "FR"
    @State private var targetLanguage = "EN"
    @State private var isTranslate = false
    @State private var showSourceLanguagePicker = false
    @State private var showTargetLanguagePicker = false
    
    let languages = ["EN", "DE", "ES", "IT", "NL", "PL", "PT", "RU", "FR"]
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "repeat.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.green)
                    .padding(.top, 1)
                
                Text("Traduction")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .bold()
                    .padding(.top, 1)
            }
            
            HStack(spacing: 2) {
                Button(action: {
                    showSourceLanguagePicker.toggle()
                }) {
                    Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: getFlagURL(for: sourceLanguage))!))!)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(10)
                }
                .actionSheet(isPresented: $showSourceLanguagePicker) {
                    ActionSheet(title: Text("Sélectionnez la langue source"), buttons: languages.map { language in
                        .default(Text(language)) {
                            sourceLanguage = language
                        }
                    } + [.cancel()])
                }
                
                Text("->")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button(action: {
                    showTargetLanguagePicker.toggle()
                }) {
                    Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: getFlagURL(for: targetLanguage))!))!)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(10)
                }
                .actionSheet(isPresented: $showTargetLanguagePicker) {
                    ActionSheet(title: Text("Sélectionnez la langue cible"), buttons: languages.map { language in
                        .default(Text(language)) {
                            targetLanguage = language
                        }
                    } + [.cancel()])
                }
            }
            .padding(.horizontal, 10)
            
            TextField("Entrez le texte à traduire", text: $textToTranslate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            
            Button(action: {
                translateText(text: textToTranslate, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage) { translated in
                    if let translated = translated {
                        translatedText = translated
                        isTranslate = true
                    } else {
                        translatedText = "Erreur de traduction"
                    }
                }
            }) {
                Text("Traduire")
                    .font(.headline)
                    .bold()
                    .padding()
                    .frame(minWidth: 150)
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .shadow(color: .green, radius: 10, x: 0, y: 5)
            }
            .padding(.top, 20)
            
            if isTranslate {
                VStack(spacing: 10) {
                    Text("Texte traduit :")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top, 10)
                    
                    Text(translatedText)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .transition(.slide)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
