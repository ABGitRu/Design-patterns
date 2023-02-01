//
//  SimpleIterator.swift
//  Design patterns
//
//  Created by Mac on 01.05.2022.
//

import Foundation

/// простой итератор
class SimpleIterator {
    /// числа для итераций
    var numbers = [1,2,3,4,5]

    /// запутстить итерацию
    func iterate() {
        /// самый простой способ итерирования шаг за шагом
        for number in numbers {
            print(number)
        }
    }
}
