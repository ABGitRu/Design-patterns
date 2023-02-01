//
//  StrategyViewController.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

///  вьюконтроллер паттерна "Стратегия"
final class StrategyViewController: UIViewController {

    /// кнопка к которой применяется стратегия
    var superButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Strategy Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        let specialButton = SpecialButton(strategy: ButtonWithRoundedCorner())
        return specialButton.specialButton(button: button)
    }()

    /// тип выбранной стратегии
    var typeOfStrategy = TypeOfStrategy.rounded

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addButtonTargets()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(superButton)
        
        NSLayoutConstraint.activate([
            superButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            superButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            superButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            superButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    // добавить экшн для кнопки
    private func addButtonTargets() {
        superButton.addTarget(self, action: #selector(changeStrategy), for: .touchUpInside)
    }

    /// сменить стратегию
    @objc private func changeStrategy() {
        switch typeOfStrategy {
        case .rounded:
            typeOfStrategy = .branded
            let specialButton = SpecialButton(strategy: ButtonBranded())
            superButton = specialButton.specialButton(button: superButton)
        case .branded:
            typeOfStrategy = .bordered
            let specialButton = SpecialButton(strategy: ButtonWithBorder())
            superButton = specialButton.specialButton(button: superButton)
        case .bordered:
            typeOfStrategy = .rounded
            let specialButton = SpecialButton(strategy: ButtonWithRoundedCorner())
            superButton = specialButton.specialButton(button: superButton)
        }
    }
}
