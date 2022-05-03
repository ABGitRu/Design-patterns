//
//  AbstractFactoryViewController.swift
//  Design patterns
//
//  Created by Mac on 17.04.2022.
//

import UIKit

/// Вью контроллер паттерна "Абстрактная фабрика"
final class AbstractFactoryViewController: UIViewController {
    
    // массив компаний
    private let companies = Companies.allCases
    // массив сервисов Apple
    private let appleServices = AppleServices.allCases
    // массив сервисов Android
    private let androidServices = AndroidServices.allCases
    // массив компонентов для пикер вью
    private let pickerComponents = PickerComponents.allCases

    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    // пикервью экрана
    private let servicePicker = UIPickerView()
    // лейбл для отображения url из полученного из фабрики
    private let serviceUrlLabel = UILabel()

    // инстанс фабрики
    private var factory = CompanyServiceFactory(company: .apple)

    // теущая выбранная компания
    private var currentCompany: Companies?

    // текущий выбранный сервис
    private var currentServise: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPickers()
        setupServiceLabel()
    }

    // настройка вью
    private func setupView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }

    // настройка пикервью
    private func setupPickers() {
        servicePicker.dataSource = self
        servicePicker.delegate = self

        view.addSubview(servicePicker)

        servicePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            servicePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            servicePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            servicePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            servicePicker.heightAnchor.constraint(equalToConstant: 164)
        ])
    }

    // настройка лейбла с url из фабрики
    private func setupServiceLabel() {
        view.addSubview(serviceUrlLabel)

        serviceUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceUrlLabel.textColor = .black
        serviceUrlLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            serviceUrlLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            serviceUrlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            serviceUrlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // получить ссылку из фабрики
    /// - parameters:
    /// - company: компания
    /// - appleService: перечисление сервисов Apple
    /// - androidService: перечисление сервисов Android
    private func getUrl(company: Companies) {
        switch currentServise as? AppleServices {
        case .apple:
            factory = CompanyServiceFactory(company: company, appleService: .apple)
        case .appleDeveloper:
            factory = CompanyServiceFactory(company: company, appleService: .appleDeveloper)
        case .none:
            break
        }

        switch currentServise as? AndroidServices {
        case .android:
            factory = CompanyServiceFactory(company: company, androidService: .android)
        case .androidDeveloper:
            factory = CompanyServiceFactory(company: company, androidService: .androidDeveloper)
        case .none:
            break
        }
        
        guard let url = factory.create()?.url else { return }
        serviceUrlLabel.text = "Your url is: \(url)"
    }
}

// MARK: - UIPickerViewDataSource
extension AbstractFactoryViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        companies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch companies[component] {
        case .apple:
            return appleServices.count
        case .android:
            return androidServices.count
        }
    }
    
    
}
// MARK: - UIPickerViewDelegate
extension AbstractFactoryViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerComponents[component] {
        case .companies: return companies[row].rawValue
        case .services:
            switch currentCompany {
            case .apple: return appleServices[row].rawValue
            case .android: return androidServices[row].rawValue
            case .none:
                return nil
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerComponents[component] {
        case .companies:
            switch companies[row] {
            case .apple:
                currentCompany = .apple
                currentServise = AppleServices.apple
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.reloadAllComponents()
                getUrl(company: .apple)
            case .android:
                currentCompany = .android
                currentServise = AndroidServices.android
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.reloadAllComponents()
                getUrl(company: .android)
            }
        case .services:
            switch currentCompany {
            case .apple:
                switch appleServices[row] {
                case .apple:
                    currentServise = AppleServices.apple
                    getUrl(company: .apple)
                case .appleDeveloper:
                    currentServise = AppleServices.appleDeveloper
                    getUrl(company: .apple)
                }
            case .android:
                switch androidServices[row] {
                case .android:
                    currentServise = AndroidServices.android
                    getUrl(company: .android)
                case .androidDeveloper:
                    currentServise = AndroidServices.androidDeveloper
                    getUrl(company: .android)
                }
            case .none: break
            }
        }
    }
}
