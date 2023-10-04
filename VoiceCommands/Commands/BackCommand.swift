//
//  BackCommand.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
class BackCommand:CommandBase {
    override var listeningTime: Int {
        return 0
    }
    override var name: String {
        return "back"
    }
   
    override func execute(session: CommandsSession, args: [Int]?) {
        session.back()
    }
    override var commandName: String {
        return BackCommand.commandKey
    }
    override class var commandKey: String {
        return "back".localized()
        }
    
   
}
