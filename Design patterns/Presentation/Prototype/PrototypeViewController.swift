//
//  PrototypeViewController.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

/// вьюконтроллер паттерна "Прототип"
final class PrototypeViewController: UIViewController {
    
    /// прототип кнопки
    var prototype = PrototypeButton()

    /// первый клон
    var cloneOne: UIButton!
    /// второй клон
    var cloneTwo: UIButton!
    /// третий клон
    var cloneThree: UIButton!

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        cloneButtons()
        setView()
        addButtonTargets()
    }

    /// создать клоны кнопок
    private func cloneButtons() {
        cloneOne = prototype.cloneButton()
        cloneTwo = prototype.cloneButton()
        cloneThree = prototype.cloneButton()
    }

    /// добавить экшн в каждую кнопку
    private func addButtonTargets() {
        cloneOne.addTarget(self, action: #selector(cloneOneAction), for: .touchUpInside)
        cloneTwo.addTarget(self, action: #selector(cloneTwoAction), for: .touchUpInside)
        cloneThree.addTarget(self, action: #selector(cloneThreeAction), for: .touchUpInside)
    }

    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(cloneOne)
        view.addSubview(cloneTwo)
        view.addSubview(cloneThree)
        
        NSLayoutConstraint.activate([
            cloneOne.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cloneOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cloneOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cloneOne.heightAnchor.constraint(equalToConstant: 48),
            
            cloneTwo.bottomAnchor.constraint(equalTo: cloneOne.topAnchor, constant: -32),
            cloneTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cloneTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cloneTwo.heightAnchor.constraint(equalToConstant: 48),
            
            cloneThree.bottomAnchor.constraint(equalTo: cloneTwo.topAnchor, constant: -32),
            cloneThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cloneThree.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cloneThree.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    /// экшн первого клона
    @objc private func cloneOneAction() {
        print("Я кнопка номер 1")
    }

    /// экшн второго клона
    @objc private func cloneTwoAction() {
        print("Я кнопка номер 2")
    }

    /// экшн третьего клона
    @objc private func cloneThreeAction() {
        print("Я кнопка номер 3")
    }
}

/// Кнопка прототип которую можно клонировать
final class PrototypeButton {
    var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Меня можно клонировать", for: .normal)
        button.backgroundColor = .green
        return button
    }()

    /// клонировать кнопку
    func cloneButton() -> UIButton {
        let prototype = PrototypeButton()
        return prototype.button
    }
}
