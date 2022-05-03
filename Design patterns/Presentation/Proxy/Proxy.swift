//
//  Proxy.swift
//  Design patterns
//
//  Created by Mac on 28.04.2022.
//

import Foundation

/// протокол сетевого соединения
protocol NetworkProtocol {

    /// данные получаемые из сети
    var data: Data? { get set }
    
    /// загрузить данные
    /// - Parameters:
    /// - complition: комплишн блок с данными
    func fetchData(complition: @escaping ((Data) -> ()))
}

/// Сетевой менеджер
final class NetManager: NetworkProtocol {

    var data: Data?

    // инстанс user defaults
    let defaults = UserDefaults.standard

    func fetchData(complition: @escaping ((Data) -> ())) {
        guard let url = URL(string: ConstantNames.appleLink.rawValue) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            complition(data)
            self.data = data
            self.defaults.set(self.data, forKey: "image")
        }.resume()
    }
}

/// Сетевой менеджер с возможностью не осуществлять загрузку если данные уже есть
final class ProxyNetManager: NetworkProtocol {
    var data: Data?

    // инстанс user defaults
    let defaults = UserDefaults.standard

    /// сетевой сервис
    var service: NetManager

    /// инициализатор
    /// - Parameters:
    /// - service: сетевой сервис
    init(service: NetManager) {
        self.service = service
        data = defaults.data(forKey: "image")
    }

    func fetchData(complition: @escaping ((Data) -> ())) {
        if data == nil {
            service.fetchData { data in
                complition(data)
                self.data = data
            }
        }
    }
}
