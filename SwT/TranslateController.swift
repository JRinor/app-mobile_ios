//
//  TranslateController.swift
//  iosProject
//
//  Created by Lucas Plateau on 5/17/24.
//

import Foundation

func translateText(text: String, sourceLanguage: String, targetLanguage: String, completion: @escaping (String?) -> Void) {
    let apiKey = "91a05bf1-099b-4288-a4fe-edda0fdb6e80:fx"
    let url = URL(string: "https://api-free.deepl.com/v2/translate")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let parameters: [String: String] = [
        "auth_key": apiKey,
        "text": text,
        "source_lang": sourceLanguage,
        "target_lang": targetLanguage
    ]
    
    request.httpBody = parameters.map { "\($0)=\($1)" }.joined(separator: "&").data(using: .utf8)
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Erreur lors de la requête : \(error!.localizedDescription)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("Aucune donnée reçue")
            completion(nil)
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let translations = json["translations"] as? [[String: Any]],
               let translation = translations.first?["text"] as? String {
                completion(translation)
            } else {
                print("Format de réponse inattendu")
                completion(nil)
            }
        } catch {
            print("Erreur de décodage JSON : \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    task.resume()
}

func getFlagURL(for language: String) -> String {
    let baseURL = "https://flagsapi.com/"
    let countryCode: String
    
    switch language {
    case "EN": countryCode = "GB"
    case "DE": countryCode = "DE"
    case "ES": countryCode = "ES"
    case "IT": countryCode = "IT"
    case "NL": countryCode = "NL"
    case "PL": countryCode = "PL"
    case "PT": countryCode = "PT"
    case "RU": countryCode = "RU"
    case "FR": countryCode = "FR"
    default: countryCode = "GB"
    }
    
    return "\(baseURL)\(countryCode)/flat/64.png"
}
