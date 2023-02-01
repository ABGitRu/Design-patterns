//
//  StateViewController.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

/// вьюконтроллер паттерна "State"
final class StateViewController: UIViewController {

    /// Кнопка для загрузки данных
    var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Загрузить картинку", for: .normal)
        return button
    }()

    /// Кнопка для открытия соединения
    var openConnectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("Открыть соединение", for: .normal)
        return button
    }()

    /// Кнопка для закрытия соединения
    var closeConnectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Закрыть соедение", for: .normal)
        return button
    }()

    /// Лейбл с информацией по текущему состоянию
    var stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // обьект состояния связи
    private let connection = Connection()

    /// экземпляр сетевого менеджера
    var networkManager: NetworkManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNetworkManager()
        setupView()
        addButtonsTargets()
        setInfoLabel()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(button)
        view.addSubview(openConnectionButton)
        view.addSubview(closeConnectionButton)
        view.addSubview(stateLabel)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 48),
            openConnectionButton.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -64),
            openConnectionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            openConnectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            openConnectionButton.heightAnchor.constraint(equalToConstant: 48),
            closeConnectionButton.bottomAnchor.constraint(equalTo: openConnectionButton.topAnchor, constant: -16),
            closeConnectionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeConnectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeConnectionButton.heightAnchor.constraint(equalToConstant: 48),
            stateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    /// настроить сетевого менеджера
    private func setupNetworkManager() {
        guard let url = URL(string: "https://www.iphones.ru/wp-content/uploads/2016/01/Apple-Swift-Main.jpg") else
        { return }
        networkManager = NetworkManager(url: url)
    }

    /// установить текущий статус в информационный лейбл
    private func setInfoLabel() {
        stateLabel.text = connection.info
    }

    /// добавить экшн в каждую кнопку
    private func addButtonsTargets() {
        button.addTarget(self, action: #selector(download), for: .touchUpInside)
        openConnectionButton.addTarget(self, action: #selector(openConnection), for: .touchUpInside)
        closeConnectionButton.addTarget(self, action: #selector(closeConnection), for: .touchUpInside)
    }

    /// начать загрузку
    @objc private func download() {
        if connection.toggle {
            stateLabel.text = "начинаю скачивать..."
            networkManager?.doFetch { data in
                DispatchQueue.main.async {
                    self.stateLabel.text = "Скачалось: \(data)"
                }
            }
        } else {
            stateLabel.text = "Доступ в сеть запрещен, откройте доступ"
        }
    }

    /// открыть соединение
    @objc private func openConnection() {
        connection.open()
        setInfoLabel()
    }

    /// закрыть соединение
    @objc private func closeConnection() {
        connection.close()
        setInfoLabel()
    }
}
