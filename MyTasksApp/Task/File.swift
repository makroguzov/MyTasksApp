//
//  Task.swift
//  MyTasksApp
//
//  Created by Валерий Макрогузов on 14.11.2020.
//

import UIKit

protocol File {
    var name: String { get }
    var description: String { get }
    var delegate: FilePresentable? { get set }
    func createViewController() -> UIViewController
}

extension File {
    func open() {
        let viewController = createViewController()
        delegate?.present(viewController, animated: true)
    }
}
