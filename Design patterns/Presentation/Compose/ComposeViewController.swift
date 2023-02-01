//
//  ComposeViewController.swift
//  Design patterns
//
//  Created by Mac on 24.04.2022.
//

import UIKit

/// вьюконтроллер паттерна "Compose"
final class ComposeViewController: UIViewController {
    
    // инстанс синглтона с настройками для вью экрана
    private let settings = SettingsSingleton.instance

    /// таблица
    private let tableView = UITableView()

    private var currentFolder: Compose = Folder(name: "Главная папка")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupTableView()
        setupNavigationItems()
    }

    /// настроить айтемы навигационной панели
    private func setupNavigationItems() {
        let file = UIBarButtonItem(title: "Файл", style: .plain, target: self, action: #selector(fileTapped))
        let folder = UIBarButtonItem(title: "Папка", style: .plain, target: self, action: #selector(folderTapped))

        navigationItem.rightBarButtonItems = [file, folder]
    }

    /// обработчик нажатия на кнопку файл
    @objc private func fileTapped() {
        currentFolder.addComponent(c: File(name: "новый файл"))
        tableView.reloadData()
    }
    /// обработчик нажатия на кнопку папка
    @objc private func folderTapped() {
        currentFolder.addComponent(c: Folder(name: "новая папка"))
        tableView.reloadData()
    }

    /// настроить таблицу
    private func setupTableView() {
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "table")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// настроить вью
    private func setView() {
        view.backgroundColor = settings.backgroundColor
        navigationController?.navigationBar.tintColor = settings.navigationTintColor
    }
}

// MARK: UITableViewDataSource
extension ComposeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = (currentFolder.showContent() as? [Compose])?.count else { return 0 }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table", for: indexPath)
        guard let item = (currentFolder.showContent() as? [Compose])?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = item.name

        if item is Folder {
            cell.detailTextLabel?.text = "Папка"
        } else {
            cell.detailTextLabel?.text = "Файл"
        }
        
        return cell
    }
}
// MARK: UITableViewDelegate
extension ComposeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = (currentFolder.showContent() as? [Compose])?[indexPath.row] else { return }

        if item is Folder {
            let vc = ComposeViewController()
            vc.currentFolder = item
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("\(item.showContent())")
        }
    }
}
