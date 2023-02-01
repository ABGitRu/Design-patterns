//
//  AdapterViewController.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

/// Протокол добавления текста
protocol AddLabelProtocol {
    func addText(text: String)
}

/// Вьюконтроллер паттерна "Адаптер"
final class AdapterViewController: Adapter {

    /// простая машина
    let simpleCar = Ford()
    /// простой мотоцикл
    let simpleBike = BMW()

    /// адаптированый байк
    var bikeAdapter: CarProtocol?

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addText(text: "Добавленный текст")
        createAdapter()
        startTest()
    }

    /// создать адаптированый байк
    private func createAdapter() {
        bikeAdapter = BWMAdapter(adaptee: simpleBike)
    }

    /// запустить тест транспорта
    /// - parameters:
    /// - transport: транспорт для теста
    private func makeTransportTest(transport: CarProtocol) {
        transport.startEngine()
        transport.drive()
    }

    /// начать тест с готовыми экземплярами
    private func startTest() {
        guard let bikeAdapter = bikeAdapter else { return }
        makeTransportTest(transport: simpleCar)
        makeTransportTest(transport: bikeAdapter)
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }
}

/// Класс адаптер для вью контроллера
class Adapter: UIViewController, AddLabelProtocol {

    /// добавить текст на экран с заданым именем
    func addText(text: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        view.addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Другой пример адаптера

/// Протокол автомобиля
protocol CarProtocol {
    /// запуск двигателя
    func startEngine()
    /// начать поездку
    func drive()
}

/// Класс автомобиля форд
final class Ford: CarProtocol {
    func startEngine() {
        print("Двигатель работает")
    }
    
    func drive() {
        print("едем, все четыре колеса крутятся")
    }
}
/// протокол мотоцикла
protocol BikeProtocol {
    /// запуск двигателя мотоцикла
    func pullEngineStarter()
    /// начать поездку
    func drive()
}

/// Класс мотоцикла BMW
final class BMW: BikeProtocol {
    func pullEngineStarter() {
        print("Топливный кран открыт, рычаг обогатителя вытянут, двигатель работает ")
    }
    
    func drive() {
        print("Едем, оба колеса крутятся")
    }
}

/// Класс адаптер для мотоцикла
final class BWMAdapter: CarProtocol {
    // байк который требует адаптации
    private let bike: BMW
    
    /// инициализатор
    /// - parameters:
    /// - adaptee: объект для адаптации
    init(adaptee: BMW) {
        self.bike = adaptee
    }

    /// запуск двигателя
    func startEngine() {
        bike.pullEngineStarter()
    }

    /// начать поездку
    func drive() {
        bike.drive()
    }
}
