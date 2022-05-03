//
//  FactoryViewController.swift
//  Design patterns
//
//  Created by Mac on 16.04.2022.
//

import UIKit

/// Вью контроллер фабричного паттерна
final class FactoryViewController: UIViewController {

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // фабрика
    private let factory = AirPlaneFactory()

    // инстанс со всеми возможными самолетами
    private let planes = Planes.allCases

    // пикер для возможности выбрать определенный самолет
    private let picker = UIPickerView()

    // лейбл с максимальной скоростью самолета
    private let maxSpeedLabel = UILabel()

    // лейбл с длиной самолета
    private let planeLenghtLabel = UILabel()

    // лейбл с размахом крыла самолета
    private let wingsLenghtLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPicker()
        setupLabels()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    // настройка пикервью
    private func setupPicker() {
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)

        NSLayoutConstraint.activate([
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // настройка лейблов
    private func setupLabels() {
        let labels = [maxSpeedLabel, planeLenghtLabel, wingsLenghtLabel]

        for label in labels {
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textColor = .black
        }

        NSLayoutConstraint.activate([
            maxSpeedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            maxSpeedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            maxSpeedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            planeLenghtLabel.topAnchor.constraint(equalTo: maxSpeedLabel.bottomAnchor, constant: 16),
            planeLenghtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            planeLenghtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            wingsLenghtLabel.topAnchor.constraint(equalTo: planeLenghtLabel.bottomAnchor, constant: 16),
            wingsLenghtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            wingsLenghtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - UIPickerViewDataSource
extension FactoryViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        planes.count / planes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        planes.count
    }
}
// MARK: - UIPickerViewDelegate
extension FactoryViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = planes[row].rawValue
        return row
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let planeType = planes[row]
        let plane = factory.getPlane(planeType: planeType)

        maxSpeedLabel.text = "Максимальная скорость: \(plane.maxSpeed)"
        planeLenghtLabel.text = "Длина самолета: \(plane.planeLenght)"
        wingsLenghtLabel.text = "Длина крыльев: \(plane.wingsLenght)"
    }
}
