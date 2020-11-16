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
    
    override var navigationController: NavigationController? {
        self.navigationController
    }
    // MARK: - SetUp Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp(tableView: tableView)
    }
    
    func setUp(files: [File]) {
        self.files = files
    }

    private func setUp(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files[indexPath.row]
        open(file: file)
    }
    
    internal func open(file: File) {
        return
    }
    
}

// MARK: - BarButtonsActionPeforming

protocol BarButtonsActionPeforming: AnyObject {
    func create(_ file: File)
}

extension TasksViewController: BarButtonsActionPeforming {
    func create(_ file: File) {
        files.append(file)
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
