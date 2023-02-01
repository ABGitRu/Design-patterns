//
//  ObserverViewController.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

/// протокол издателя
protocol Publisher {
    /// добавить слушателя
    func addListener(listener: Listener)
    /// удалить слушателя
    func removeListener(listener: Listener)
    /// отправить сообщение
    func sendMessage()
}

/// протокол слушателя
protocol Listener {
    /// произвести действие по получению сообщения
    func doAction()
}

/// Вью контроллер паттерна "Наблюдатель"
final class ObserverViewController: UIViewController, Listener {

    /// Данные с картинкой
    private var imageData: Data?

    /// контейнер для картинки
    var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "eye.fill")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// экземпляр сетевого менеджера
    var networkManager: NetworkManager?

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNetworkManager()
        setupView()
        fetch()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    /// настроить сетевого менеджера
    private func setupNetworkManager() {
        guard let url = URL(string: "https://www.iphones.ru/wp-content/uploads/2016/01/Apple-Swift-Main.jpg") else
        { return }
        networkManager = NetworkManager(url: url)
        networkManager?.addListener(listener: self)
    }

    /// совершить запрос данных
    private func fetch() {
        networkManager?.doFetch { data in
            self.imageData = data
        }
    }

    /// обновить контейнер картинки если получим сообщение от паблишера
    func doAction() {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: self.imageData ?? Data())
        }
    }
}
