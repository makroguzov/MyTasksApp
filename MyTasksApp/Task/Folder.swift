//
//  Folder.swift
//  MyTasksApp
//
//  Created by Валерий Макрогузов on 14.11.2020.
//

import UIKit

class Folder: File {
    
    var name: String
    var delegate: FilePresentable?
    var description: String {
        return "File named: \(name)"
    }

    private var files = [File]()

    init(name: String) {
        self.name = name
    }
    
    func createViewController() -> UIViewController {
        return TasksViewController()
    }

}
