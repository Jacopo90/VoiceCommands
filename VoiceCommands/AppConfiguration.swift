//
//  AppConfiguration.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
class AppConfiguration{
    static let shared = AppConfiguration()
    static var availableLanguages = ["en": "en-US","ita":"it-IT"]
    func loadDefault(){
        self.changeLanguage(key: AppConfiguration.availableLanguages.values.first!)
    }
    func changeLanguage(key: String){
        UserDefaults.standard.setValue(key, forKey: "k_app_language")
    }
    func currentLanguage()-> String{
        if (UserDefaults.standard.value(forKey: "k_app_language") == nil){
            return AppConfiguration.availableLanguages.values.first!
        }
        return UserDefaults.standard.value(forKey: "k_app_language") as! String
    }
   
}
