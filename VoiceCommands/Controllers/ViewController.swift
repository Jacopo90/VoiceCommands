//
//  ViewController.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 02/10/23.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate{
    var audioEngine: AVAudioEngine?
    var speechRecognizer: SFSpeechRecognizer?
    var request: SFSpeechAudioBufferRecognitionRequest? = nil
    var recognitionTask: SFSpeechRecognitionTask?
    let commandFactory = CommandsFactory.shared
    let session = CommandsSession()
    let noDataView = NoDataView()
    
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var activeCommandLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var listView: UITableView!
    
    @IBOutlet weak var speechText: UILabel!
    
    @IBOutlet weak var allCommandsButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var languageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.session.delegate = self
        
        audioEngine = AVAudioEngine()
        self.listView.register(UINib(nibName: "CommandActionCell", bundle: nil), forCellReuseIdentifier: "CommandActionCell")
        self.listView.delegate = self
        self.listView.dataSource = self
        self.listView.separatorColor = .clear
        self._configureAudioSession()
        
        self.noDataView.frame = self.listView.frame
        self.view.addSubview(self.noDataView)
        self.refresh()
    }
    func loadLanguage(){
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: AppConfiguration.shared.currentLanguage()))
        self.languageLabel.text = speechRecognizer?.locale.identifier
        self.changeCurrentCommandLabel(text: "-")


    }
    override func viewWillAppear(_ animated: Bool) {
        self.loadLanguage()
        self.updateUI(state: self.session.state)
    }
    @IBAction func stop(){
        self.session.stop()
    }
    @IBAction func changeLanguage(){
        let list = ListController(_presenter: ListLanguagePresenter());
        self.navigationController?.pushViewController(list, animated: true)
    }
    @IBAction func addCommand(){
        let list = ListController(_presenter: ActiveCommandsPresenter());
        self.navigationController?.pushViewController(list, animated: true)
        
    }
    @IBAction func rec(_ sender: Any) {
        self.session.state = SessionState.waitingForCommand
    }
    
    
    private func startRecording(){
        
        if let _request = self.request{
            
            guard let myRecognizer  = speechRecognizer else {
                return
            }
            if !myRecognizer.isAvailable{
                return
            }
            
            if let node = audioEngine?.inputNode {
                let recordingFormat = node.outputFormat(forBus: 0)
                if recordingFormat.sampleRate == 0.0 { return }
                
                node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { _buffer, _ in
                    _request.append(_buffer)
                    print("...")
                }
                
                audioEngine?.prepare()
                do {
                    try audioEngine?.start()
                }
                catch {
                    return print(error)
                }
             
                recognitionTask = speechRecognizer?.recognitionTask(with: _request, resultHandler: { result, error in
                    if let _result = result{
                        let string = _result.bestTranscription.formattedString
                        self.speechText.text = string
                        switch self.session.state {
                        case .listening:
                            let array = string.components(separatedBy: " ")

                            self.session.handleArgs(args: self.recognizeNumbers(valueString: array.last!))
                            if let __command: CommandBase = self.commandFactory.commandFrom(keyCommand: array.last!){
                                self.changeCurrentCommandLabel(text: __command.commandName)
                                self.session.handleCommand(command: __command)
                            }
                            
                            break
                        case .waitingForCommand:
                            self.changeCurrentCommandLabel(text: "-")
                            let array = string.components(separatedBy: " ")
                            if let __command = self.commandFactory.commandFrom(keyCommand: array.last!){
                                self.changeCurrentCommandLabel(text: __command.commandName)

                                self.session.handleCommand(command: __command)
                            }
                            break
                            
                            
                        default:
                            print("still listening")
                        }
                        
                    }else if let _error = error{
                        print(_error)
                    }
                })
            }  }
        
    }
    private func recognizeNumbers(valueString :String ) -> [Int]{
        let array = valueString.components(separatedBy: " ")
        let numberFormatter = NumberFormatter()
        var _args:[Int] = []
        for item in array {
            if let value = (numberFormatter.number(from: item.lowercased()) as? Int){
                _args.append(value)
            }
        }
        
        return _args
    }
    private func stopRecording() {
        self.audioEngine?.stop()
        self.audioEngine?.inputNode.removeTap(onBus: 0)
        self.request = nil
        self.recognitionTask?.cancel()
    }
    
    private func _configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }
    }
    func changeCurrentCommandLabel(text: String){
        self.activeCommandLabel.text = "\("current_command".localized()) : \(text)"
    }
    func refresh(){
        self.changeCurrentCommandLabel(text: "-")
        self.listView.isHidden = !(self.session.commandsHistory.count > 0)
        self.noDataView.isHidden = self.session.commandsHistory.count > 0
    }
}

extension ViewController: CommandsSessionProtocol {
    func stopRecord() {
        self.stopRecording()
        
    }
    
    func listen() {
        self.speechText.text = "-"
        self.stopRecording()
        self.request  = SFSpeechAudioBufferRecognitionRequest()
        self.startRecording()
    }
    func lastExecutedCommand(command: CommandBase) {
        print("just executed : \(command.name)")
        self.session.save(command: command)
        self.refresh()
    }
    func askRefresh() {
        self.listView.reloadData()
    }
   
    func stateDidChanged(state: SessionState) {
        self.updateUI(state: state)
    }
    func updateUI(state: SessionState){
        self.speechText.text = "-"
        self.titleLabel.text = "commands_list".localized()
        self.allCommandsButton.setTitle("active_commands".localized(), for: .normal)
        self.languageButton.setImage(UIImage(systemName: "search"), for: .normal)
        self.allCommandsButton.layoutIfNeeded()
        self.allCommandsButton.layoutSubviews()
        self.noDataView.loadUI()
        switch state {
        case SessionState.listening:
            self.stateLabel.text = "\("state".localized()): \("listening".localized())"
            self.listenButton.setTitle("listening".localized(), for: .normal)
            self.listenButton.isEnabled = false
            self.cleanButton.isEnabled = true
            break
        case SessionState.waitingForCommand:
            self.stateLabel.text = "\("state".localized()): \("waiting".localized())"
            self.listenButton.setTitle("waiting".localized(), for: .normal)
            self.listenButton.isEnabled = false
            self.cleanButton.isEnabled = true
            break
        case SessionState.none:
            self.listenButton.isEnabled = true
            self.cleanButton.isEnabled = false
            self.listenButton.setTitle("listen".localized(), for: .normal)
            self.stateLabel.text = "\("state".localized()): \("none".localized())"
            break
        }
       
    }
}

