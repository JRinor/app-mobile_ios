import SwiftUI

import Foundation
import Combine

struct IPInfo: Codable {
    let ip: String
    let country_name: String
    let city_name: String
}

class IPInfoViewModel: ObservableObject {
    @Published var ipInfo: IPInfo?

    private var cancellable: AnyCancellable?

    func fetchIPInfo(for ip: String) {
        guard let url = URL(string: "https://api.ip2location.io/?key=A37C221BAD336DEE0C3047032B0DFF25&ip=\(ip)") else {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: IPInfo.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching IP info: \(error)")
                }
            }, receiveValue: { [weak self] ipInfo in
                self?.ipInfo = ipInfo
            })
    }
}
