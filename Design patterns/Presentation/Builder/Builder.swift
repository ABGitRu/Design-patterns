//
//  Builder.swift
//  Design patterns
//
//  Created by Mac on 24.04.2022.
//

import Foundation

/// класс игрока
final class Player {
    /// имя
    var name: String?
    /// сила
    var strength: Int?
    /// ловкость
    var dexterity: Int?
    /// интелект
    var intelligence: Int?
    /// здоровье
    var health: Int?
}

/// протокол строителя
protocol PlayerBuilder {
    /// перезагрузить компонент
    func reset()

    /// установить имя
    func setName(name: String)
    /// установить силу
    func setStrength(strength: Int)
    /// установить ловкость
    func setDexterity(dexterity: Int)
    /// установить интеллект
    func setIntelligence(intelligence: Int)
    /// установить здоровье
    func setHealth(health: Int)
    
    /// получить игрока
    func getPlayer() -> Player
}

/// класс основного игрока
final class PlayerOne: PlayerBuilder {

    /// обьект игрока который можно собрать
    private var player = Player()

    func reset() {
        player = Player()
    }
    
    func setName(name: String) {
        player.name = name
    }
    
    func setStrength(strength: Int) {
        player.strength = strength
    }
    
    func setDexterity(dexterity: Int) {
        player.dexterity = dexterity
    }
    
    func setIntelligence(intelligence: Int) {
        player.intelligence = intelligence
    }
    
    func setHealth(health: Int) {
        player.health = health
    }
    
    func getPlayer() -> Player {
        return player
    }
}
