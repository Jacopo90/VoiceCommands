//
//  config.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
class ConfigCommand:CommandBase {
    override var listeningTime: Int {
        return 0
    }
    override var name: String {
        return "close"
    }
   
    override func execute(session: CommandsSession, args: [Int]?) {
    }
    
    override var commandName: String {
        return ConfigCommand.commandKey
    }
    override class var commandKey: String {
        return "config".localized()
        }
}
