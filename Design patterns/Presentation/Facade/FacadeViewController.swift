//
//  FacadeViewController.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

/// вьюконтроллер паттерна "Facade"
final class FacadeViewController: UIViewController {

    /// рубильник света
    var lightSwitch: UISwitch = {
       let lightSwitch = UISwitch()
        lightSwitch.translatesAutoresizingMaskIntoConstraints = false
        lightSwitch.addTarget(self, action: #selector(lightToggle), for: .touchUpInside)
        return lightSwitch
    }()

    /// рубильник музыки
    var musicSwitch: UISwitch = {
       let lightSwitch = UISwitch()
        lightSwitch.translatesAutoresizingMaskIntoConstraints = false
        lightSwitch.addTarget(self, action: #selector(musicToggle), for: .touchUpInside)
        return lightSwitch
    }()

    /// рубильник видео
    var videoSwitch: UISwitch = {
       let lightSwitch = UISwitch()
        lightSwitch.translatesAutoresizingMaskIntoConstraints = false
        lightSwitch.addTarget(self, action: #selector(videoToggle), for: .touchUpInside)
        return lightSwitch
    }()

    /// главный рубильник
    var mainSwitch: UISwitch = {
       let lightSwitch = UISwitch()
        lightSwitch.translatesAutoresizingMaskIntoConstraints = false
        lightSwitch.addTarget(self, action: #selector(mainToggle), for: .touchUpInside)
        return lightSwitch
    }()

    /// фасад рубильников
    let facade = EnergyFacade(lightSwitch: LightSwitch(), musicSwitch: MusicSwitch(), videoSwitch: VideoSwitch())

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addConstraints()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// контроллер рубильников
    func switchControl() {
        lightSwitch.setOn(facade.lightSwitch.toggle, animated: true)
        musicSwitch.setOn(facade.musicSwitch.toggle, animated: true)
        videoSwitch.setOn(facade.videoSwitch.toggle, animated: true)
        mainSwitch.setOn(mainSwitchState(), animated: true)
    }

    /// получить статус основного рубильника
    func mainSwitchState() -> Bool {
        return mainSwitch.isOn
    }

    /// установить констрейнты
    func addConstraints() {
        view.addSubview(lightSwitch)
        view.addSubview(musicSwitch)
        view.addSubview(videoSwitch)
        view.addSubview(mainSwitch)
        let constraints: [NSLayoutConstraint] = [
            lightSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            lightSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicSwitch.topAnchor.constraint(equalTo: lightSwitch.bottomAnchor, constant: 16),
            musicSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoSwitch.topAnchor.constraint(equalTo: musicSwitch.bottomAnchor, constant: 16),
            videoSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainSwitch.topAnchor.constraint(equalTo: videoSwitch.bottomAnchor, constant: 32),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    /// селектор музыкального рубильника
    @objc private func musicToggle() {
        facade.musicSwitch.toggle.toggle()
    }
    /// селектор светого рубильника
    @objc private func lightToggle() {
        facade.lightSwitch.toggle.toggle()
    }
    /// селектор видео рубильника
    @objc private func videoToggle() {
        facade.videoSwitch.toggle.toggle()
    }
    /// селектор главного рубильника
    @objc private func mainToggle() {
        facade.togglePower(mainPowerIsOn: mainSwitchState())
        switchControl()
    }
}
