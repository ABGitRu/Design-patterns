//
//  Strategy.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import UIKit

/// перечисление стратегий
enum TypeOfStrategy {
    /// закгругленные края
    case rounded
    /// брендированый цвет
    case branded
    /// с дополнительными бортиками по границе view
    case bordered
}

/// протокол стратегии
protocol Strategy {
    /// стратегия для возврата кнопки с новой стратегией
    func specialButton(button: UIButton) -> UIButton
}

/// Класс кнопки со скругленными краями
final class ButtonWithRoundedCorner: Strategy {

    func specialButton(button: UIButton) -> UIButton {
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 12
        button.backgroundColor = .white
        return button
    }
}

/// Класс кнопки с "брендированым"  цветом
final class ButtonBranded: Strategy {

    func specialButton(button: UIButton) -> UIButton {
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 0
        button.backgroundColor = .green
        return button
    }
}

/// Класс кнопки с дополнительными границами
final class ButtonWithBorder: Strategy {
    func specialButton(button: UIButton) -> UIButton {
        button.layer.cornerRadius = 0
        button.backgroundColor = .red
        button.layer.borderWidth = 8
        button.layer.borderColor = CGColor(red: 0.25, green: 0.40, blue: 0.9, alpha: 1)
        return button
    }
}

/// Класс специальной кноки к которой можно применять стратегию
final class SpecialButton: Strategy {

    // инстантс стратегии
    private var instance: Strategy

    /// инициализатор
    /// - Parameters:
    /// - strategy: стратегия
    init(strategy: Strategy) {
        self.instance = strategy
    }

    /// установить стратегию
    func setStrategy(strategy: Strategy) {
        self.instance = strategy
    }

    /// получить кнопку с установленной стратегией
    func specialButton(button: UIButton) -> UIButton {
        instance.specialButton(button: button)
    }
}
