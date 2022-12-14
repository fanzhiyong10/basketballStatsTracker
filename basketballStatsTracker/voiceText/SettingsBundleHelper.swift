//
//  SettingsBundleHelper.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/9.
//

import Foundation
class SettingsBundleHelper {
    
    struct SettingsBundleKeys {
        static let wordOfTrainSpeechRecognize = "wordOfTrainSpeechRecognize"
        
        // speech control
        static let isResponseOnSpeechControl = "isResponseOnSpeechControl"
        
        // recognize voice command:
        static let recognizeVoiceCommand = "recognizeVoiceCommand"
    }
    
    // =====================================
    class func fetchRecognizeVoiceCommand() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.recognizeVoiceCommand) {
            return result
        } else {
            return nil
        }
    }

    class func saveRecognizeVoiceCommand(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.recognizeVoiceCommand)
    }

    // =====================================
    class func fetchWordOfTrainSpeechRecognize() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.wordOfTrainSpeechRecognize) {
            return result
        } else {
            return nil
        }
    }

    class func saveWordOfTrainSpeechRecognize(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.wordOfTrainSpeechRecognize)
    }

    // =====================================
    // 是否响应声控
    class func fetchIsResponseOnSpeechControl() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.isResponseOnSpeechControl) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.isResponseOnSpeechControl)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.isResponseOnSpeechControl)
            return 0
        }
    }
    
    class func saveIsResponseOnSpeechControl(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.isResponseOnSpeechControl)
    }
}
