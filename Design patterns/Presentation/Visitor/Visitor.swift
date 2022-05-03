//
//  Visitor.swift
//  Design patterns
//
//  Created by Mac on 02.05.2022.
//

import Foundation

/// протокол посетителя
protocol Visitor {
    /// посетить
    /// - Parameters:
    /// - person: персона
    func visit(person: Person)

    /// посетить
    /// - Parameters:
    /// - note: заметка
    func visit(note: Note)
}

/// протокол акцептора
protocol Acceptor {
    /// показать данные
    /// - Parameters:
    /// - visitor: данные визитора
    func showData(visitor: Visitor)
}

/// класс персоны
class Person: Acceptor {
    var name: String = ""
    var secondName: String = ""
    var email: String = ""

    func showData(visitor: Visitor) {
        visitor.visit(person: self)
    }
}

/// класс заметки
class Note: Acceptor {
    var title: String = ""
    var text: String = ""

    func showData(visitor: Visitor) {
        visitor.visit(note: self)
    }
}

/// класс генерирующий общий txt документ (строку со всеми данными)
class GeneratorTXT: Visitor {
    var txt: String = ""

    func visit(person: Person) {
        txt += person.name + ", " + person.secondName + ", " + person.email
    }
    
    func visit(note: Note) {
        txt += note.title + ", " + note.text
    }

    /// создать текстовый документ  (строку со всеми данными)
    /// - Parameters:
    /// - array: входящие объекты подписаные под протокол Acceptor
    func createTXT(array: [Acceptor]) {
        txt = ""
        for a in array {
            a.showData(visitor: self)
        }
    }
}
