//
//  ChainOfResponsibilityViewController.swift
//  Design patterns
//
//  Created by Mac on 30.04.2022.
//

import UIKit

/// вьюконтроллер паттерна "ChainOfResponsibility"
final class ChainOfResponsibilityViewController: UIViewController {
    
    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // менеджер
    private var manager: ManagerPower?

    // кнопка с выбором покупки
    private var chooseWhatToBuyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("Выбрать покупку", for: .normal)
        button.addTarget(self, action: #selector(chooseWhatToBuy), for: .touchUpInside)
        return button
    }()

    // кнопка запроса покупки
    private var makeADealButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("Купить", for: .normal)
        button.addTarget(self, action: #selector(makeADeal), for: .touchUpInside)
        return button
    }()

    // текущая выбранная покупка
    private var currentShopingItem = ShoppingList.pen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setChains()
        setupButtons()
    }

    // логика замены текущей покупки
    @objc private func chooseWhatToBuy() {
        switch currentShopingItem {
        case .pen:
            chooseWhatToBuyButton.setTitle("Принтер", for: .normal)
            currentShopingItem = .printer
        case .printer:
            chooseWhatToBuyButton.setTitle("Инвестировать", for: .normal)
            currentShopingItem = .invest
        case .invest:
            chooseWhatToBuyButton.setTitle("Ручка", for: .normal)
            currentShopingItem = .pen
        }
    }

    // логика запроса покупки
    @objc private func makeADeal() {
        switch currentShopingItem {
        case .pen:
            manager?.process(request: PurchaseRequest(amount: 2, purpose: ShoppingList.pen.rawValue))
        case .printer:
            manager?.process(request: PurchaseRequest(amount: 90, purpose: ShoppingList.printer.rawValue))
        case .invest:
            manager?.process(request: PurchaseRequest(amount: 2000, purpose: ShoppingList.invest.rawValue))
        }
    }

    // установить зависимости
    private func setChains() {
        manager = ManagerPower()
        let director = DirectorPower()
        let president = PresidentPower()

        manager?.successor = director
        director.successor = president
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    // настроить кнопки
    private func setupButtons() {
        view.addSubview(chooseWhatToBuyButton)
        view.addSubview(makeADealButton)

        NSLayoutConstraint.activate([
            chooseWhatToBuyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            chooseWhatToBuyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chooseWhatToBuyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chooseWhatToBuyButton.heightAnchor.constraint(equalToConstant: 64),

            makeADealButton.bottomAnchor.constraint(equalTo: chooseWhatToBuyButton.topAnchor, constant: -16),
            makeADealButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            makeADealButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            makeADealButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}
