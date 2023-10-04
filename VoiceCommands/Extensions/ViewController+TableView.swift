//
//  ViewController+TableView.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
import UIKit
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.session.commandsHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommandActionCell", for: indexPath)
        (cell as? CommandActionCell)!.titleLabel.text = "\("command".localized()): \(self.session.commandsHistory[indexPath.row].commandName)"
        if let params = self.session.commandsHistory[indexPath.row].value(){
            (cell as? CommandActionCell)!.valueLabel.text = "\("parameters".localized()): \((params as NSNumber).stringValue )"
        }else{
            (cell as? CommandActionCell)!.valueLabel.text = "\("parameters".localized()): \("undefined".localized())"
        }
       
        (cell as? CommandActionCell)!.jsonDescription.text = self.session.commandsHistory[indexPath.row].toJsonString()
        
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
