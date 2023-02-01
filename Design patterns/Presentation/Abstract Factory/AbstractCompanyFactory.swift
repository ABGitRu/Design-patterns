//
//  AbstractCompanyFactory.swift
//  Design patterns
//
//  Created by Mac on 17.04.2022.
//

/// перечисление сервисов Apple
enum AppleServices: String, CaseIterable {
    case apple
    case appleDeveloper
}

/// перечисление сервисов Android
enum AndroidServices: String, CaseIterable {
    case android
    case androidDeveloper
}

/// Перечисление возможных компаний
enum Companies: String, CaseIterable {
    case apple
    case android
}

/// Перечисление компонентов для пикервью экрана
enum PickerComponents: String, CaseIterable {
    case companies
    case services
}

/// общий протокол фабрики сервисов сервисов
protocol ServiceFactory {
    /// создать сервис
    /// - parameters:
    /// - service: Дженерик принмающий перечисление AndroidServices или AppleServices
    func create<T>(service: T) -> Service?
}

/// протокол сервиса
protocol Service {
    /// ссылка на сервис
    var url: String { get }
}

/// общий сервис компании Apple
class AppleService: Service {
    var url: String { return "https://www.apple.com/ru/" }
}

/// сервис компании Apple для разработчиков
class AppleDevService: Service {
    var url: String { return "https://developer.apple.com" }
}

/// фабрика сервисов Apple
class AppleServiceFactory: ServiceFactory {
    func create<T>(service: T) -> Service? {
        let service = service as? AppleServices
        switch service {
        case .apple:
            return AppleService()
        case .appleDeveloper:
            return AppleDevService()
        default: return nil
        }
    }
}

/// общий сервис Android
class AndroidService: Service {
    var url: String { return "https://www.android.com/intl/ru_ru/" }
}

/// сервис Android для разработчиков
class AndroidDevService: Service {
    var url: String { return "https://developer.android.com" }
}

/// Фабрика Android сервисов
class AndroidServiceFactory: ServiceFactory {
    func create<T>(service: T) -> Service? {
        let service = service as? AndroidServices
        switch service {
        case .android:
            return AndroidService()
        case .androidDeveloper:
            return AndroidDevService()
        default: return nil
        }
    }
}

/// Фабрика сервисов компаний
class CompanyServiceFactory {

    /// компания
    var company: Companies
    /// перечисление сервисов Apple
    var appleService: AppleServices?
    /// перечисление сервисов Android
    var androidService: AndroidServices?

    /// инициализатор
    /// - parameters:
    /// - company: компания
    /// - appleService: перечисление сервисов Apple
    /// - androidService: перечисление сервисов Android
    init(company: Companies, appleService: AppleServices? = nil, androidService: AndroidServices? = nil) {
        self.company = company
        self.appleService = appleService
        self.androidService = androidService
    }

    /// создать сервис
    func create() -> Service? {
        switch self.company {
        case .apple:
            return AppleServiceFactory().create(service: appleService)
        case .android:
            return AndroidServiceFactory().create(service: androidService)
        }
    }
}

