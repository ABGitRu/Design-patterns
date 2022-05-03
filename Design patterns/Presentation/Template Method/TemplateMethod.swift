//
//  TemplateMethod.swift
//  Design patterns
//
//  Created by Mac on 02.05.2022.
//

import UIKit

///  шаблон кнопки
class ButtonTemplate: UIButton {

    /// установить цвет текста
    func setColorTitle() {
        
    }

    /// установить цвет бэкграунда
    func setColorBackground() {
        
    }

    /// установить текст
    func setTitle() {
        
    }

    /// инициализировать кнопку
    func initialize() {
        setColorTitle()
        setColorBackground()
        setTitle()
    }
}

/// кнопка alert
final class AlertButton: ButtonTemplate {

    override func setTitle() {
        self.setTitle("Алерт", for: .normal)
    }

    override func setColorBackground() {
        self.backgroundColor = .red
    }
}

/// кнопка warning
final class WarningButton: ButtonTemplate {

    override func setColorTitle() {
        self.setTitleColor(.red, for: .normal)
    }

    override func setTitle() {
        self.setTitle("Внимание", for: .normal)
    }

    override func setColorBackground() {
        self.backgroundColor = .yellow
    }
    
}
