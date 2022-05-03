//
//  Command.swift
//  Design patterns
//
//  Created by Mac on 01.05.2022.
//

import Foundation

/// Базовая команда
protocol BaseCommand {
    func undo() -> String
    func forward(_ string: String)
}

/// команда удаления текста
final class StringUndoCommand: BaseCommand {
    // оригинальная строка
    private var originalString: String
    // текущая строка
    private var currentString: String

    /// инициализатор
    /// - Parameters:
    ///  - argument: текущая входная строка
    init(argument: String) {
        originalString = argument
        currentString = argument
    }

    /// распечатка строки для возможности отследить изменения в рантайме
    func printString() {
        print(currentString)
    }

    /// удалить чарактер в строке и вернуть текущую строку после изменений
    func undo() -> String {
        if currentString.count != 0 {
            currentString.removeLast()
        }
        printString()
        return currentString
    }

    /// добавить чарактер в текущую строку
    func forward(_ string: String) {
        currentString.append(string)
        printString()
    }
}

/// исполнитель команд
final class CommandExecutor {
    /// массив команд
    private var arrayOfCommand = [BaseCommand]()

    /// добавить команду
    /// - Parameters:
    /// - command: входящая команда для заполнения массива команд
    func addCommand(command: BaseCommand) {
        arrayOfCommand.append(command)
    }

    /// исполнение метода добавления чарактера в строку
    func forward(_ string: String) {
        for command in arrayOfCommand {
            command.forward(string)
        }
    }

    /// исполнение метода удаления чарактера из строки
    func undoLast() -> String {
        var title = String()
        for command in arrayOfCommand {
            title = command.undo()
        }
        return title
    }
}
