//
//  MainScreenController.swift
//  Design patterns
//
//  Created by Mac on 16.04.2022.
//

import UIKit

/// Экран с навигацией по разделам шаблонов проектирования
final class MainScreenController: UIViewController {

    // инстанс хранящий массив имен патернов
    private let patterns = Patterns.allCases

    // таблица главного экрана с ячейками патернов
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableViewSetup()
    }

    // настройка вью экрана
    private func setupView() {
        title = ConstantNames.mainScreenTitle.rawValue
    }

    // настройка таблицы экрана
    private func tableViewSetup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: Patterns.self))
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainScreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        patterns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Patterns.self), for: indexPath)
        cell.textLabel?.text = patterns[indexPath.row].rawValue
        return cell
    }
    
}
// MARK: - UITableViewDelegate
extension MainScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch patterns[indexPath.row] {
        case .singleton:
            navigationController?.show(SingletonViewController(), sender: nil)
        case .factory:
            navigationController?.show(FactoryViewController(), sender: nil)
        case .abstractFactory:
            navigationController?.show(AbstractFactoryViewController(), sender: nil)
        case .decorator:
            navigationController?.show(DecoratorViewController(), sender: nil)
        case .adapter:
            navigationController?.show(AdapterViewController(), sender: nil)
        case .facade:
            navigationController?.show(FacadeViewController(), sender: nil)
        case .observer:
            navigationController?.show(ObserverViewController(), sender: nil)
        case .state:
            navigationController?.show(StateViewController(), sender: nil)
        case .strategy:
            navigationController?.show(StrategyViewController(), sender: nil)
        case .prototype:
            navigationController?.show(PrototypeViewController(), sender: nil)
        case .builder:
            navigationController?.show(BuilderViewController(), sender: nil)
        case .bridge:
            navigationController?.show(BridgeViewController(), sender: nil)
        case .compose:
            navigationController?.show(ComposeViewController(), sender: nil)
        case .proxy:
            navigationController?.show(ProxyViewController(), sender: nil)
        case .chainOfResponsibility:
            navigationController?.show(ChainOfResponsibilityViewController(), sender: nil)
        case .command:
            navigationController?.show(CommandViewController(), sender: nil)
        case .iterator:
            navigationController?.show(IteratorViewController(), sender: nil)
        case .memento:
            navigationController?.show(MementoViewController(), sender: nil)
        case .templateMethod:
            navigationController?.show(TemplateMethodViewController(), sender: nil)
        case .visitor:
            navigationController?.show(VisitorViewController(), sender: nil)
        }
    }
}
