//
//  SingletonViewController.swift
//  Design patterns
//
//  Created by Mac on 16.04.2022.
//

import UIKit

/// Вьюконтроллер шаблона Singleton
final class SingletonViewController: UIViewController {

    /// инстанс синглтона с настройками для вью экрана
    let settings = SettingsSingleton.instance

    /// фейковый инстанс для проверки того что мы имеем именно синглтон
    let settingsFake = SettingsSingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkingIsSingleton()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    // проверка на предмет того действительно ли инстансы ссылаются на один объект
    private func checkingIsSingleton() {
        settings.backgroundColor = .green
        settingsFake.backgroundColor = .white
        if settings.backgroundColor == settingsFake.backgroundColor {
            print("Да, я синглтон")
            print(settings.backgroundColor)
            print(settingsFake.backgroundColor)
        }
        settings.backgroundColor = .orange
    }
}

/// Класс синглтон с настройками цветовой схемы
final class SettingsSingleton {
    // инстанс синглтона
    static var instance = SettingsSingleton()

    /// цвет для вью экрана
    var backgroundColor = UIColor.orange
    /// цвет для айтемов отображающихся в навигационной панели
    var navigationTintColor = UIColor.white

    /// приватный инициализатор для отсутствия возможности создать класс "не синглтон"
    private init() {}
}
