//
//  MementoViewController.swift
//  Design patterns
//
//  Created by Mac on 02.05.2022.
//

import UIKit

/// вьюконтроллер патерна "Memento"
final class MementoViewController: UIViewController {

    /// кнопка сохранения текущего состояния точек
    private var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()

    /// кнопка загрузки последнего сохраненого состояния точек
    private var loadButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("Загрузить", for: .normal)
        button.addTarget(self, action: #selector(load), for: .touchUpInside)
        return button
    }()

    /// холст для рисования
    private var canvas: UIView = {
        let canvas = UIView()
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.backgroundColor = .gray
        return canvas
    }()
    
    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    var carrierState: CarrierState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSubViews()
        addGesture()
        addCarrierState()
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    /// настроить сабвью
    private func setSubViews() {
        view.addSubview(saveButton)
        view.addSubview(loadButton)
        view.addSubview(canvas)

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.widthAnchor.constraint(equalToConstant: 96),
            saveButton.heightAnchor.constraint(equalToConstant: 34),

            loadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            loadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loadButton.widthAnchor.constraint(equalToConstant: 96),
            loadButton.heightAnchor.constraint(equalToConstant: 34),

            canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            canvas.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    /// добавить кериэр стейт
    private func addCarrierState() {
        let painter = Painter()
        carrierState = CarrierState(painter: painter)
    }

    /// добавить распознаватель нажатий
    private func addGesture() {
        let gr = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        canvas.gestureRecognizers = [gr]
    }

    /// сохранить точки
    @objc private func save() {
        carrierState?.save()
    }
    /// загрузить точки
    @objc private func load() {
        carrierState?.load()
        carrierState?.painter.printPoints(in: canvas)
    }

    /// обработать нажатия
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        let x = sender.location(in: canvas).x
        let y = sender.location(in: canvas).y

        carrierState?.painter.addPoint(point: Point(x: x, y: y))
        carrierState?.painter.printPoints(in: canvas)
    }
}
