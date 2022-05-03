//
//  ChainOfResponsibility.swift
//  Design patterns
//
//  Created by Mac on 30.04.2022.
//

import Foundation

/// перечисление возможных покупок
enum ShoppingList: String {
    case pen = "ручки"
    case printer = "принтера"
    case invest = "ценных бумаг"
}

/// протокол закупок
protocol PurchasePower {
    // допустимая сумма
    var allowable : Float { get }
    // роль закупающего
    var role : String { get }
    // кому доступна закупка
    var successor : PurchasePower? { get set }
}

extension PurchasePower {
    // запрос согласования
  func process(request : PurchaseRequest){
    if request.amount < self.allowable {
      print(self.role + " может согласовать покупку \(request.purpose) на \(request.amount) $")
    } else if successor != nil {
      successor?.process(request: request)
    }
  }
}

/// запрос согласования
struct PurchaseRequest {
  var amount : Float
  var purpose : String
}

/// доступная закупка менеджера
class ManagerPower : PurchasePower {
  var allowable: Float = 20
  var role : String = "Менеджер"
  var successor: PurchasePower?
}

/// доступная закупка директора
class DirectorPower : PurchasePower {
  var allowable: Float = 100
  var role = "Директор"
  var successor: PurchasePower?
}

/// доступная закупка президента
class PresidentPower : PurchasePower {
  var allowable: Float = 5000
  var role = "Президент"
  var successor: PurchasePower?
}
