//
//  ActiveCommandsPresenter.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
import UIKit

class ActiveCommandsPresenter: PresenterProtocol {
    var title: String {
        return "active_commands_title".localized()
    }
    var description: String{
        return "active_commands_description".localized()
    }
    
    var listDelegate: ListProtocol?

    func actionButton(navigationController: UINavigationController?,currentController: ListProtocol?) {
        guard let nav = navigationController else {return}
        let presenter = AllCommandsPresenter()
        presenter.listDelegate = currentController
        let form = ListController(_presenter: presenter)
        nav.present(form, animated: true)
    }
    
    func loadButton(target: Any?, action: Selector?) -> UIBarButtonItem? {
        return UIBarButtonItem(barButtonSystemItem: .add, target: target, action: action)
       
    }
    
    
    
    
    let cellId = "CommandCell"
    
    var cell: String {
        return "CommandCell"
    }
    var list: [String:Any] = CommandsFactory.shared.commands
    
    
    func loadCellForIndexPath(cell: UITableViewCell, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let commandKey = Array(list.keys)[indexPath.row]
        (cell as? CommandCell)!.titleLabel?.text = (list[commandKey] as! CommandBase.Type).commandKey
        cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 20)
        return cell
    }
    func didSelectRow(index: IndexPath, controller: UIViewController) {
        
    }
    func update() {
        self.list = CommandsFactory.shared.commands
    }
    
    
    
    
}
