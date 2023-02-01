//
//  DecoratorViewController.swift
//  Design patterns
//
//  Created by Mac on 18.04.2022.
//

import UIKit

/// Перечисление с типом апгрейда
enum ViewUpgrades {
    case none
    case firstUpgrade
    case secondUpgrade
    case thirdUpgrade
}

/// Вью контроллер для паттерна "Декоторатор"
final class DecoratorViewController: UIViewController {

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    /// кнопка для запуска апгрейдов
    private let upgradeButton = UIButton(type: .roundedRect)

    /// инстанс с вьюшкой которую необходимо декорировать
    private var decoratebleView: ViewElementProtocol = UpgradableView(view: UIView())

    /// текущий статус апгрейда
    private var currentUpgrade = ViewUpgrades.none

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUpgradableView()
        setupButton()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// настроить кнопку
    private func setupButton() {
        upgradeButton.translatesAutoresizingMaskIntoConstraints = false
        upgradeButton.setTitle(ConstantNames.doUpgrades.rawValue, for: .normal)
        upgradeButton.setTitleColor(.white, for: .normal)
        upgradeButton.titleLabel?.font = .systemFont(ofSize: 20)
        upgradeButton.backgroundColor = .green
        upgradeButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        upgradeButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        upgradeButton.layer.shadowOpacity = 1.0
        upgradeButton.layer.cornerRadius = 12
        upgradeButton.addTarget(self, action: #selector(upgradeView), for: .touchUpInside)

        view.addSubview(upgradeButton)

        NSLayoutConstraint.activate([
            upgradeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            upgradeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            upgradeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            upgradeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    /// добавить апгрейд в соответствии со статусом апгрейда
    @objc private func upgradeView() {
        switch currentUpgrade {
        case .none:
            currentUpgrade = .firstUpgrade
            decoratebleView = UpgradeBorder(element: decoratebleView, borderColor: UIColor.green.cgColor, borderWidth: 10)
        case .firstUpgrade:
            currentUpgrade = .secondUpgrade
            decoratebleView = UpgradeRadius(element: decoratebleView, cornerRadius: 12)
        case .secondUpgrade:
            currentUpgrade = .thirdUpgrade
            decoratebleView = UpgradeBackGroundColor(element: decoratebleView, color: .blue)
        case .thirdUpgrade:
            upgradeButton.setTitle(ConstantNames.upgradesCompleted.rawValue, for: .normal)
            decoratebleView = UpgradeWithAnimation(element: decoratebleView)
        }
        
    }

    /// настроить вью которую необходимо декорировать
    private func setupUpgradableView() {
        let upgradableView = decoratebleView.view
        view.addSubview(upgradableView)
        
        NSLayoutConstraint.activate([
            upgradableView.widthAnchor.constraint(equalToConstant: 200),
            upgradableView.heightAnchor.constraint(equalToConstant: 200),
            upgradableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upgradableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
