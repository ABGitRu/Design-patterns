//
//  VisitorViewController.swift
//  Design patterns
//
//  Created by Mac on 02.05.2022.
//

import UIKit

/// вьюконтроллер паттерна Visitor
final class VisitorViewController: UIViewController {

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        generateFakeData()
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// сгенерировать фейкданные
    private func generateFakeData() {
        let personOne = Person()
        personOne.name = "Alex"
        personOne.secondName = "Bridge"
        personOne.email = "email"

        let personTwo = Person()
        personTwo.name = "Boris"
        personTwo.name = "Builder"
        personTwo.email = "noEmail"

        let note = Note()
        note.title = "Заметка"
        note.text = "Текст заметки.........."
        let fakeArray: [Acceptor] = [personOne, personTwo, note]

        let txtGenerator = GeneratorTXT()
        txtGenerator.createTXT(array: fakeArray)
        print(txtGenerator.txt)
    }
}
