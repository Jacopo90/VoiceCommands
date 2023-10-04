//
//  AllCommandsPresenter.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
import UIKit

class AllCommandsPresenter:PresenterProtocol {
    var title: String {
        return "all_commands_title".localized()
    }
   
    var description: String{
        return "all_commands_description".localized()
    }
    
    func actionButton(navigationController: UINavigationController?, currentController: ListProtocol?) {
        
    }
    
    var listDelegate: ListProtocol?
 
    func loadButton(target: Any?, action: Selector?) -> UIBarButtonItem? {
        nil
    }
    
    let cellId = "CommandActionCell"
    var cell: String {
        return "CommandActionCell"
    }
    
    let list: [String:Any]  = ["count": CountCommand.self,
                               "code": CodeCommand.self,
                               "reset": ResetCommand.self,
                               "back": BackCommand.self,
                               "stop": StopCommand.self,
                               "config": ConfigCommand.self]
   
    func loadCellForIndexPath(cell: UITableViewCell, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let commandKey = Array(list.keys)[indexPath.row]
        cell.textLabel?.text = (list[commandKey] as! CommandBase.Type).commandKey
        cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 20)
        cell.backgroundColor = alreadyInList(commandKey: commandKey) ? UIColor.gray.withAlphaComponent(0.4) : UIColor.white
            return cell
    }
     func alreadyInList(commandKey: String) -> Bool{
        return CommandsFactory.shared.commands.contains { (key: String, value: CommandBase.Type) in
            return commandKey == key
        }
    }

    func didSelectRow(index: IndexPath, controller: UIViewController) {
        let commandFactory = CommandsFactory.shared
        
        let itemkey = Array(list.keys)[index.row]
        if (alreadyInList(commandKey: itemkey)){
            return
        }
        commandFactory.register(command: list[itemkey] as! CommandBase.Type , for: itemkey)
        controller.dismiss(animated: true)
        self.listDelegate?.refresh()
    }
    func update() {}
}
