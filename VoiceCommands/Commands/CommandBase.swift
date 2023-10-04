//
//  ICommand.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
class CommandBase{
    required init(){

       }
    class var commandKey: String {
            return "Base"
    }
    var commandName: String {
        return CommandBase.commandKey
    }
    var listeningTime: Int {
        return 3
    }
    
    var name: String {
        return ""
    }

    var delegate: ICommandDelegate?

    var args: [Int]?
    
    func execute(session: CommandsSession, args: [Int]?) {
        self.args = args
        self.delegate?.commandIsFinished(command: self)
    }
    func value() -> Int?{
        if let _args = args{
            var myString = ""
            _ = _args.map{ myString = myString + "\($0)" }
            return  Int(myString)
        }
        return nil
    }
    func toJson() -> NSData? {
      let jsonObject =   [
        "command": self.name,
        "value": value() as Any?
      ] as [String : Any]
        let jsonData: NSData

        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            return jsonData

        } catch _ {
            print ("JSON Failure")
        }
        return nil
    }
    func toJsonString() -> String{
        return NSString(data: toJson()! as Data, encoding: String.Encoding.utf8.rawValue)! as String
    }
}
protocol ICommandDelegate {
    func commandIsFinished(command: CommandBase)
}

