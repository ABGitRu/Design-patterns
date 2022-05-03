//
//  Iterator.swift
//  Design patterns
//
//  Created by Mac on 01.05.2022.
//

import Foundation

/// протокол итератора по числам
protocol IntIterator {
    /// первое число
    func first()
    /// следующее число
    func next()
    /// завершение итераций
    var isDone: Bool { get }
    /// текущее число
    var currentItem: Int { get }
}

/// протокол получения Итератора
protocol IntAggregate {
    /// получить итератор
    func getIterator() -> IntIterator
}

/// Класс с цифрами для подсчета
final class PrimeNumbers: IntAggregate {
    let numbers = [1,2,3,4,5]

    func getIterator() -> IntIterator {
        return Iterator(self)
    }
}

/// итератор цифр
final class Iterator: IntIterator {
    /// текущий индекс числа
    private var index = 0
    /// инстанс класса с цифрами для подсчета
    private let parent: PrimeNumbers

    /// инициализатор
    /// - Parameters:
    /// - parent: обьект с цифрами для подсчета
    init(_ parent: PrimeNumbers) {
        self.parent = parent
    }

    func first() {
        index = 0
    }

    func next() {
        index += 1
    }

    var isDone: Bool {
        return index >= parent.numbers.count
    }

    var currentItem: Int {
        return parent.numbers[index]
    }
}
