//
//  TasksViewController.swift
//  MyTasksApp
//
//  Created by Валерий Макрогузов on 14.11.2020.
//

import UIKit


class TasksViewController: UIViewController {
        
    static let id: String = "TasksViewController"
    
    private var files = [File]()
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .grouped)
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp(tableView)
        setUp(navigationItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - SetUp Methods

    func setUp(files: [File]) {
        self.files = files
    }

    private func setUp(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    private func setUp(_ navigationItem: UINavigationItem) {
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem  = .init(systemItem: .add,
                                                       primaryAction: nil, menu: createMenu())
        } else {
            return
        }
    }
    
    // MARK: - private Methods
    
    private func createMenu() -> UIMenu {
        
        let createFolder = UIAction(title: "Folder", image: nil, identifier: nil,
                                    discoverabilityTitle: nil, attributes: .init(),
                                    state: .mixed) { [weak self] (_) in
            self?.createFolderAction()
        }
        
        
        let menu = UIMenu(title: "Create", image: nil, identifier: nil, options: .displayInline,
                          children: [createFolder])
        return menu
    }

    private func createFolderAction() {
        let alert = UIAlertController(title: "Create folder", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "type name ..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) {  [weak self] _ in
            guard let self = self else {
                return
            }
            
            if let name = alert.textFields?.first?.text {
                let folder = Folder(name: name)
                folder.delegate = self
                self.files.append(folder)
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let file = files[indexPath.row]
        
        cell.textLabel?.text = file.name
        cell.imageView?.image = file.image
        return cell
    }

}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files[indexPath.row]
        file.open()
    }
}

// MARK: - FilePresentable

protocol FilePresentable: AnyObject {
    func present(_ viewController: UIViewController, animated: Bool)
}

extension TasksViewController: FilePresentable {
    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}


extension TasksViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil,
                                                       previewProvider: nil) { [weak self] _ -> UIMenu? in
            
            return self?.createMenu()
        }
        return configuration
    }
    
}
