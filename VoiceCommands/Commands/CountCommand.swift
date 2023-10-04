//
//  CountCommand.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation

class CountCommand: CommandBase {
    override class var commandKey: String {
        return "count".localized()
        }
    
    override var name: String {
        return "count"
    }
    override var commandName: String {
        return CountCommand.commandKey
    }
    
}
