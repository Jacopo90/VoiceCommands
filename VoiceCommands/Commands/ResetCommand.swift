//
//  ResetCommand.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
class ResetCommand:CommandBase {
    override var listeningTime: Int {
        return 0
    }
    override var name: String {
        return "reset"
    }
    override func execute(session: CommandsSession, args: [Int]?) {
        session.resetCurrent()

    }
    override var commandName: String {
        return ResetCommand.commandKey
    }
    override class var commandKey: String {
        return "reset".localized()
        }
}
