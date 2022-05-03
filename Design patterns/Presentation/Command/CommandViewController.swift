//
//  CommandViewController.swift
//  Design patterns
//
//  Created by Mac on 01.05.2022.
//

import UIKit

/// вьюконтроллер паттерна "Command"
final class CommandViewController: UIViewController {

    // текстфилд для ввода текста
    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите текст"
        textField.borderStyle = .roundedRect
        return textField
    }()

    // кнопка удаления текста
    private var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        button.addTarget(self, action: #selector(deleteText), for: .touchUpInside)
        return button
    }()
    
    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // исполнитель команд
    private let commandExecutor = CommandExecutor()
    // команда удаления
    var commandUndo: StringUndoCommand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSubViews()
        textField.delegate = self
    }

    /// удалить текст
    @objc private func deleteText() {
        textField.text = commandExecutor.undoLast()
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// настроить сабвью
    private func setSubViews() {
        view.addSubview(textField)
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}

// MARK: - UITextFieldDelegate
extension CommandViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        commandUndo = StringUndoCommand(argument: textField.text ?? "")

        guard let commandUndo = commandUndo else { return false }
        commandExecutor.addCommand(command: commandUndo)
        commandExecutor.forward(string)
        return true
    }
}
