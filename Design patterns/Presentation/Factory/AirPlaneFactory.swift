//
//  AirPlaneFactory.swift
//  Design patterns
//
//  Created by Mac on 16.04.2022.
//
 import Foundation

/// перечисление возможных самолетов
enum Planes: String, CaseIterable {
    case boeing737 = "Боинг 737"
    case airBusA320 = "Аирбас А320"
    case il76 = "ИЛ-76"
}

/// протокол для всех самолетов
protocol AirPlane {
    /// максимальная скорость
    var maxSpeed: Int { get }
    /// длина самолета
    var planeLenght: Int { get }
    /// размах крыла самолета
    var wingsLenght: Int { get }
}

/// класс самолета боинг
final class Boeing737: AirPlane {

    var maxSpeed: Int = 852
    
    var planeLenght: Int = 42
    
    var wingsLenght: Int =  34
}

/// класс самолета аирбас
final class AirBusA320: AirPlane {

    var maxSpeed: Int = 840
    
    var planeLenght: Int = 44
    
    var wingsLenght: Int = 34
}

/// класс самолета ИЛ-76
final class IL76: AirPlane {

    var maxSpeed: Int = 850
    
    var planeLenght: Int = 46
    
    var wingsLenght: Int = 50
}

/// фабрика самолетов
final class AirPlaneFactory {

    /// получить самолет в привязке к его типу из перечисления Planes
    /// - parameters:
    /// - planeType: тип самолета
    func getPlane(planeType: Planes) -> AirPlane {
        switch planeType {
        case .boeing737:
            return Boeing737()
        case .airBusA320:
            return AirBusA320()
        case .il76:
            return IL76()
        }
    }
}
