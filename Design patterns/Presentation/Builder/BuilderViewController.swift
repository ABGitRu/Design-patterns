//
//  BuilderViewController.swift
//  Design patterns
//
//  Created by Mac on 24.04.2022.
//

import UIKit

/// вьюконтроллер паттерна "Builder"
final class BuilderViewController: UIViewController {

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    /// персонаж игрока
    let playerOne = PlayerOne()

    /// основной информационный лейбл
    var mainLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Ваш персонаж:"
        return label
    }()

    /// лейбл имя игрока
    var playerNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    /// лейбл сила игрока
    var playerStrengthLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    /// лейбл ловкость игрока
    var playerDexterityLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    /// лейбл интеллект игрока
    var playerIntelligenceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    /// лейбл здоровье игрока
    var playerHealthLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    var createPlayerButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать нового игрока", for: .normal)
        button.backgroundColor = .green
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setPlayerLabels()
        addTargetToButton()
    }

    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(createPlayerButton)

        NSLayoutConstraint.activate([
            createPlayerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createPlayerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createPlayerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createPlayerButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    /// настроить лейблы с информацией о персонаже
    private func setPlayerLabels() {
        view.addSubview(mainLabel)
        view.addSubview(playerNameLabel)
        view.addSubview(playerHealthLabel)
        view.addSubview(playerStrengthLabel)
        view.addSubview(playerDexterityLabel)
        view.addSubview(playerIntelligenceLabel)

        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            playerNameLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 32),
            playerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            playerHealthLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 16),
            playerHealthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerHealthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            playerStrengthLabel.topAnchor.constraint(equalTo: playerHealthLabel.bottomAnchor, constant: 16),
            playerStrengthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerStrengthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            playerDexterityLabel.topAnchor.constraint(equalTo: playerStrengthLabel.bottomAnchor, constant: 16),
            playerDexterityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerDexterityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            playerIntelligenceLabel.topAnchor.constraint(equalTo: playerDexterityLabel.bottomAnchor, constant: 16),
            playerIntelligenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerIntelligenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    /// настроить нового игрока
    private func buildPlayer() {
        playerOne.reset()
        playerOne.setName(name: "Player")
        playerOne.setHealth(health: Int.random(in: 1...10))
        playerOne.setStrength(strength: Int.random(in: 1...10))
        playerOne.setDexterity(dexterity: Int.random(in: 1...10))
        playerOne.setIntelligence(intelligence: Int.random(in: 1...10))
    }

    /// загрузить в лейблы информацию об игроке
    private func loadLabelsWithPlayer() {
        let player = playerOne.getPlayer()

        playerNameLabel.text = player.name
        playerHealthLabel.text = "Здоровье: \(player.health ?? 0)"
        playerStrengthLabel.text = "Сила: \(player.strength ?? 0)"
        playerDexterityLabel.text = "Ловкость: \(player.dexterity ?? 0)"
        playerIntelligenceLabel.text = "Интеллект: \(player.intelligence ?? 0)"
    }

    /// добавить экшн в кнопку
    private func addTargetToButton() {
        createPlayerButton.addTarget(self, action: #selector(createUser), for: .touchUpInside)
    }

    /// создать пользователя
    @objc private func createUser() {
        buildPlayer()
        loadLabelsWithPlayer()
    }
}
