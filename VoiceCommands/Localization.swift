//
//  Localization.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
extension String{
 
    func localized() -> String{
        let language = AppConfiguration.shared.currentLanguage()
        let array = language.components(separatedBy: "-")
        let current = array.first
        let path = Bundle.main.path(forResource: current, ofType: "lproj")
       
        let bundle =  path != nil ? Bundle(path: path!) : nil
        return NSLocalizedString(self, tableName: nil, bundle: bundle ?? .main, value: "", comment: "")
        }
}
