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
    var image = UIImage(systemName: "folder")
    var description: String {
        return "File named: \(name)"
    }

    private var files = [File]()

    init(name: String) {
        self.name = name
        
    }
    
    func createViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TasksViewController.id)
        controller.title = name
        
        return controller
    }

}
