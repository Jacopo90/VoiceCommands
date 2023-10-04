//
//  CommandsSession.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
protocol CommandsSessionProtocol{
    func lastExecutedCommand(command: CommandBase)
    func listen()
    func stopRecord()
    func askRefresh()
    func stateDidChanged(state: SessionState)
    
}
enum SessionState{
    case waitingForCommand
    case listening
    case none
}
class CommandsSession: ICommandDelegate{
    private var _state: SessionState = SessionState.none
    var timer: Timer?
    var counter = 0
    var tmpCommand: CommandBase?
    var tmpArgs: [Int]?
    
    var state: SessionState {
        set {
            self.delegate?.stateDidChanged(state: newValue)

            if (_state == newValue){
                print("error")
                return
            }
            if (newValue == SessionState.listening){
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            if (newValue == SessionState.waitingForCommand){
                self.delegate?.listen()

            }
            if (newValue == SessionState.none){
                self.delegate?.stopRecord()
            }
            _state = newValue
        }
        get {
            return _state
        }
    }
    func invalidateTimer(){
        counter = 0
        timer?.invalidate()
        timer = nil
    }
    @objc func timerAction() {
        print("count \(counter)")
        if (counter == tmpCommand?.listeningTime){
            invalidateTimer()
            if let _command = tmpCommand{
                _command.execute(session: self, args: tmpArgs)
            }
            return
        }else{
            counter += 1
        }
    }
    var delegate: CommandsSessionProtocol?
    
    func commandIsFinished(command: CommandBase) {
        self.delegate?.lastExecutedCommand(command: command)
        self.delegate?.askRefresh()
        self.state = SessionState.waitingForCommand
    }
    
    var commandsHistory: [CommandBase] = []
    
    func back(){
        if (self.commandsHistory.count >= 1){
            self.commandsHistory.removeLast()
            self.tmpCommand = nil
            self.tmpArgs = nil
            self.state = SessionState.none
            self.state = SessionState.waitingForCommand
            self.delegate?.askRefresh()

        }
    }
    func clear(){
        commandsHistory.removeAll()
    }
    func handleArgs(args: [Int]){
        tmpArgs = args
        print(tmpArgs ?? [])

    }
    func handleCommand(command: CommandBase){
        command.delegate = self
        if (command.listeningTime != 0){
            self.state = SessionState.listening
            tmpCommand = command
        }else{
            command.execute(session: self, args: tmpArgs)
        }
    }
    
    func save(command:CommandBase){
        commandsHistory.append(command)
        print(commandsHistory)
        tmpCommand = nil
        tmpArgs = nil
    }
 
    func resetCurrent(){
        self.tmpCommand = nil
        self.tmpArgs = nil
        self.invalidateTimer()
        self.state = SessionState.none
        self.state = SessionState.waitingForCommand
    }
    func stop(){
        self.tmpCommand = nil
        self.tmpArgs = nil
        self.invalidateTimer()
        self.state = SessionState.none
    }
}
