//
//  ProxyViewController.swift
//  Design patterns
//
//  Created by Mac on 28.04.2022.
//

import UIKit

/// Вьюконтроллер паттерна "Proxy"
final class ProxyViewController: UIViewController {

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // контейнер для картинки
    private var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// сетевой сервис с возможностью не загружать из сети данные если данные уже есть
    private var networkService: ProxyNetManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        loadImage()
    }

    // загрузить изображение
    private func loadImage() {
        networkService = ProxyNetManager(service: NetManager())
        if !imageCached() {
            networkService?.fetchData { data in
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }

    }

    // проверить есть ли изображение в памяти
    private func imageCached() -> Bool {
        if networkService?.data == nil {
            return false
        } else {
            guard let imageData = networkService?.data else { return false }
            self.imageView.image = UIImage(data: imageData)
            return true
        }
    }

    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
