import SwiftUI

import Foundation
import Combine

struct PhoneInfos: Codable {
    let phone: String
    let country: String
    let phone_type: String
    let carrier: String
}

class PhoneInfoControllerModel: ObservableObject {
    @Published var phoneInfos: PhoneInfos?

    private var cancellable: AnyCancellable?

    func fetchPhoneInfos(for num: String) {
        guard let url = URL(string: "https://api.veriphone.io/v2/verify?phone=\(num)&key=CF3E549738D146A9ADEC370BBD56AB25") else {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PhoneInfos.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching IP info: \(error)")
                }
            }, receiveValue: { [weak self] phoneInfos in
                self?.phoneInfos = phoneInfos
            })
    }
}
