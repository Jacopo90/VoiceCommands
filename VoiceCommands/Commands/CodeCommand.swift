//
//  CodeCommand.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation

class CodeCommand:CommandBase {
    override class var commandKey: String {
        return "code".localized()
        }
    override var name: String {
        return "code"
    }
    override var commandName: String {
        return CodeCommand.commandKey
    }
}
