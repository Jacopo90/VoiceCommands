//
//  ListLanguagePresenter.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
import UIKit
class ListLanguagePresenter:PresenterProtocol {
    var title: String {
        return "all_languages_title".localized()
    }
    var description: String{
        return "all_languages_description".localized()
    }
    let cellId = "CommandCell"
 
    var cell:String {
        return "CommandCell"
    }

    
    var list: [String : Any] = AppConfiguration.availableLanguages
    
    var listDelegate: ListProtocol?
    
    func loadCellForIndexPath(cell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        (cell as? CommandCell)!.titleLabel?.text = Array(self.list.keys)[indexPath.row]
        (cell as? CommandCell)!.titleLabel?.font = UIFont.italicSystemFont(ofSize: 20)
        (cell as? CommandCell)!.titleLabel?.textColor = alreadySelected(language: list[Array(self.list.keys)[indexPath.row]] as! String) ? UIColor.orange : UIColor.black
        return cell
    }
    func alreadySelected(language: String) -> Bool{
        return AppConfiguration.shared.currentLanguage() == language
   }
    func loadButton(target: Any?, action: Selector?) -> UIBarButtonItem? {
        return nil
    }
    
    func actionButton(navigationController: UINavigationController?, currentController: ListProtocol?) {
        
    }
    
    func didSelectRow(index: IndexPath, controller: UIViewController) {
        AppConfiguration.shared.changeLanguage(key: self.list[Array(self.list.keys)[index.row]] as! String)
        controller.navigationController?.popViewController(animated: true)
    }
    
    func update() {
        
    }
    
}
