//
//  NetworkManager.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import Foundation

/// Класс менеджер работы с сетью
final class NetworkManager: Publisher {

    /// слушатели
    var listeners = NSMutableArray()

    /// добавить слушателя
    func addListener(listener: Listener) {
        listeners.add(listener)
    }

    /// удалить слушателя
    func removeListener(listener: Listener) {
        listeners.remove(listener)
    }

    /// отправить сообщение
    func sendMessage() {
        for l in listeners {
            print("начинаем работу по помещению ваших данных в контейнер картинки")
            (l as? Listener)?.doAction()
        }
    }

    /// url по котому необходимо произвести запрос
    var url: URL

    /// запрос
    var request: URLRequest

    /// ответ на запрос
    var dataResponse: ()?

    /// инициализатор
    /// - Parameters:
    /// - url: урл по которому необходимо провести запрос
    init(url: URL) {
        self.url = url
        request = URLRequest(url: url)
    }

    /// запросить данные
    /// - Parameters:
    /// - dataResponce: ответ на запрос
    func doFetch(dataResponce: @escaping (Data) -> ()) {
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                self.dataResponse = dataResponce(data)
                self.sendMessage()
            }
        }.resume()
    }
}
