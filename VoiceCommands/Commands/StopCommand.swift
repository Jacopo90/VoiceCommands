//
//  closeCommand.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
class StopCommand:CommandBase {
    override var listeningTime: Int {
        return 0
    }
    override var name: String {
        return "stop"
    }
   
    override func execute(session: CommandsSession, args: [Int]?) {
        session.stop()
    }
    override var commandName: String {
        return StopCommand.commandKey
    }
    override class var commandKey: String {
        return "stop".localized()
        }
    
   
}
