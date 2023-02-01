//
//  IteratorViewController.swift
//  Design patterns
//
//  Created by Mac on 01.05.2022.
//

import UIKit

/// вьюконтроллер паттерна "Iterator"
final class IteratorViewController: UIViewController {
    
    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // инстанс с числами для итерации
    private let numbers = PrimeNumbers()

    // инсанс просторого итератора **Для второго примера**
    private let simpleIterator = SimpleIterator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setIterator()
        simpleIterator.iterate()
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// настрои и запустить итератор
    private func setIterator() {
        let iterator = numbers.getIterator()
        var sum = 0
        iterator.first()
        while (!iterator.isDone) {
            sum += iterator.currentItem
            iterator.next()
        }
        print("Сумма: \(sum)")
    }
}
