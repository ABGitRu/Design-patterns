//
//  State.swift
//  Design patterns
//
//  Created by Mac on 23.04.2022.
//

import Foundation

/// протокол состояния
protocol State {
    /// открыть соединение
    func open(_ c: Connection)
    /// закрыть соединение
    func close(_ c: Connection)
}

/// класс открытого состояния
final class OpenState: State {
    func open(_ c: Connection) {
        c.info = "Вы пытаетесь повторно открыть Соединение"
    }
    
    func close(_ c: Connection) {
        c.info = "Соединение закрыто"
        c.setState(CloseState(), toggle: false)
    }
}

/// класс закрытого состояния
final class CloseState: State {
    func open(_ c: Connection) {
        c.info = "Соединение открыто"
        c.setState(OpenState(), toggle: true)
    }
    
    func close(_ c: Connection) {
        c.info = "Вы пытаетесь повторно закрыть Соединение"
    }
    
    
}

/// класс соединения
final class Connection {

    /// текущее состояние соединения
    private var state: State = CloseState()

    /// рубильник для соединения
    var toggle = false

    /// информация по текущему соединению
    var info = ""

    /// открыть соединение
    func open() {
        state.open(self)
    }

    /// закрыть соединение
    func close() {
        state.close(self)
    }

    /// установить состояние
    func setState(_ state: State, toggle: Bool) {
        self.state = state
        self.toggle = toggle
    }
}
