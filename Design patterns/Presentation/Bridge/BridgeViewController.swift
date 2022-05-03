//
//  BridgeViewController.swift
//  Design patterns
//
//  Created by Mac on 24.04.2022.
//

import UIKit

///  Вьюконтроллер паттерна "Bridge"
final class BridgeViewController: UIViewController {

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // удаленное управление
    private let remote = Remote()

    /// рубильник света
    var lightSwitch: UISwitch = {
       let lightSwitch = UISwitch()
        lightSwitch.translatesAutoresizingMaskIntoConstraints = false
        lightSwitch.addTarget(self, action: #selector(lightToggle), for: .touchUpInside)
        return lightSwitch
    }()

    /// квадрат имитация света
    var lightRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupDevice()
    }

    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor

        view.addSubview(lightSwitch)
        view.addSubview(lightRectangle)

        NSLayoutConstraint.activate([
            lightSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            lightSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            lightRectangle.heightAnchor.constraint(equalToConstant: 200),
            lightRectangle.widthAnchor.constraint(equalToConstant: 200),
            lightRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lightRectangle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }

    /// настроить связь между удаленным управлением и девайсом
    private func setupDevice() {
        remote.device = Light()
    }

    /// экшн светого рубильника
    @objc private func lightToggle() {
        let state = lightSwitch.isOn

        switch state {
        case true: remote.on() ; lightState()
        case false: remote.off() ; lightState()
        }
    }

    /// текущий стейт освещения
    private func lightState() {
        lightRectangle.backgroundColor = remote.device?.toggle ?? false ? .white : .black
    }
}

/// протокол девайса
protocol DeviceProtocol {

    /// рубильник девайса
    var toggle: Bool? { get set }

    /// включить девайс
    func on()
    /// выключить девайс
    func off()
}

/// Класс удаленного управления девайсом
final class Remote {
    /// девайс который необходимо подключить к удаленному контроллеру
    var device: DeviceProtocol?

    /// включить девайс
    func on() {
        device?.on()
    }

    /// выключить девайс
    func off() {
        device?.off()
    }
}

/// класс девайса "Свет"
final class Light: DeviceProtocol {

    var toggle: Bool?

    func on() {
        toggle = true
    }
    
    func off() {
        toggle = false
    }
}
