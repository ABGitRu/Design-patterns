//
//  Compose.swift
//  Design patterns
//
//  Created by Mac on 24.04.2022.
//

import Foundation

/// протокол компоновщика
protocol Compose {
    /// имя объекта
    var name: String { get set }

    /// показать контент
    func showContent() -> Any

    /// добавить компонент
    func addComponent(c: Compose)
}

/// Класс файла
final class File: Compose {
    /// имя файла
    var name: String

    /// инициализатор файла
    /// - Parameters:
    /// - name: имя файла
    init(name: String) {
        self.name = name
    }
    
    func showContent() -> Any {
        return name
    }
    
    func addComponent(c: Compose) {
        print("К файлу нельзя добавить папку")
    }
}

/// Класс папки
final class Folder: Compose {
    /// имя папки
    var name: String

    /// содержимое папки
    var content: [Compose] = []

    /// инициализатор папки
    /// - Parameters:
    /// - name: имя папки
    init(name: String) {
        self.name = name
    }
    
    func showContent() -> Any {
        return content
    }
    
    func addComponent(c: Compose) {
        content.append(c)
    }
}
