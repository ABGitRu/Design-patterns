//
//  TemplateMethodViewController.swift
//  Design patterns
//
//  Created by Mac on 02.05.2022.
//

import UIKit

/// вью контроллер паттерна "Template Method"
final class TemplateMethodViewController: UIViewController {
    
    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    /// кнопка alert
    private var alertButton: AlertButton = {
        let button = AlertButton(type: .roundedRect)
        button.initialize()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    /// кнопка warning
    private var warningButton: WarningButton = {
        let button = WarningButton(type: .roundedRect)
        button.initialize()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSubViews()
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// настроить сабвью
    private func setSubViews() {
        view.addSubview(alertButton)
        view.addSubview(warningButton)

        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            alertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            alertButton.heightAnchor.constraint(equalToConstant: 64),

            warningButton.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -16),
            warningButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warningButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            warningButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}
