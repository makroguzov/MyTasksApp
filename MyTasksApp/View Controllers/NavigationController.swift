//
//  NavigationController.swift
//  MyTasksApp
//
//  Created by Валерий Макрогузов on 14.11.2020.
//

import UIKit

class NavigationController: UINavigationController {
    
    var currentController: BarButtonsActionPeforming?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        isNavigationBarHidden = false
        
        navigationBar.barStyle = .default
        navigationItem.rightBarButtonItem  = .init(barButtonSystemItem: .add,
                                                   target: self, action: #selector(showContextMenu(_:)))
    }
    
    
    @objc private func showContextMenu(_ sender: UIBarButtonItem) {
        let interaction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(interaction)
    }
    
}

extension NavigationController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil,
                                                       previewProvider: nil) { [weak self] _ -> UIMenu? in
            
            return self?.createMenu()
        }
        return configuration
    }
    
    private func createMenu() -> UIMenu {
        let createFolder = UIAction(title: "Create folder", image: nil,
                                    identifier: nil, attributes: []) { [weak self] _ in
            let alert = UIAlertController(title: "Create folder", message: nil, preferredStyle: .actionSheet)
            
            alert.addTextField { (textField) in
                textField.placeholder = "type name ..."
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "Ok", style: .default) {  [weak self] _ in
                if let name = alert.textFields?.first?.text {
                    let folder = Folder(name: name)
                    self?.currentController?.create(folder)
                }
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            
            self?.present(alert, animated: true, completion: nil)
        }
        
        return UIMenu.init(title: "Menu", children: [createFolder])
    }
   
}
