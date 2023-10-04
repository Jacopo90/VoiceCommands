//
//  CommandsFactory.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
class CommandsFactory {

static let shared = CommandsFactory()

    var commands:[String:CommandBase.Type] = [:]
    func register(command: CommandBase.Type, for key: String){
        commands[key] = command
    }
    func commandFrom(keyCommand: String) -> CommandBase?{
        print("key \(keyCommand)")
        var currentCommand: CommandBase?
        commands.forEach { (key: String, value: CommandBase.Type) in
            if (keyCommand.lowercased() == value.commandKey){
                currentCommand = value.init()
            }
        }
        return currentCommand
    }

}
