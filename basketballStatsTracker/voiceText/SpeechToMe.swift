//
//  SpeechToMe.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/9.
//

import UIKit
import Speech
import os.log

/// 字符串是否包含声控指令
///
/// 去掉末尾的标点符号
func containSpeechCommand(strInput: String, word: String) -> Bool {
    var str = strInput
    
    // 结尾标点符号
    let signArr = [".", "。", "?", "？", ",", "，"]
    if let last = str.last, signArr.contains(String(last)) {
        str.removeLast()
    }
    
    // words are not case sensitive
    if str.lowercased().hasSuffix(word.lowercased()) {
        return true
    }
    
    return false
}

struct PlayerVoiceWords {
    // Player
    var player: String
    
    // voice words
    var words: [String]
    
    // stored locally
    var speechComandWords: String
    
    // used for recognize
    // First word is player
    var wordsForRecognize: [String] {
        var result = [String]()
        result.append(player.lowercased())
        
        result += words
        
        return result
    }
}

struct NumberVoiceWords {
    // Number
    var number: String
    
    // voice words
    var words: [String]
    
    // stored locally
    var speechComandWords: String
    
    // used for recognize
    // First word is number
    var wordsForRecognize: [String] {
        var result = [String]()
        result.append(number)
        
        result += words
        
        return result
    }
}

struct WordCommandAndNotification {
    // Command
    var command: String
    
    // 话语
    var words: [String]
    
    // 通知
    var notification: Notification.Name
}

public class SpeechToMe: NSObject {
    var playerVoiceWords: [PlayerVoiceWords]?
    
    // 话语-通知，入参：使用者传入
    var myWordCommandAndNotifications: [WordCommandAndNotification]? {
        var result = [WordCommandAndNotification]()
        
        var command = WordCommandAndNotification(command: "MAKE", words: SpeechCommandWords.toMake, notification: .toMake)
        result.append(command)
        
        command = WordCommandAndNotification(command: "MISS", words: SpeechCommandWords.toMiss, notification: .toMiss)
        result.append(command)
        
        command = WordCommandAndNotification(command: "BUCKET", words: SpeechCommandWords.toBucket, notification: .toBucket)
        result.append(command)
        
        command = WordCommandAndNotification(command: "BRICK", words: SpeechCommandWords.toBrick, notification: .toBrick)
        result.append(command)
        
        command = WordCommandAndNotification(command: "SWISH", words: SpeechCommandWords.toSwish, notification: .toSwish)
        result.append(command)
        
        command = WordCommandAndNotification(command: "OFF", words: SpeechCommandWords.toOff, notification: .toOff)
        result.append(command)
        
        command = WordCommandAndNotification(command: "BOARD", words: SpeechCommandWords.toBoard, notification: .toBoard)
        result.append(command)
        
        command = WordCommandAndNotification(command: "GLASS", words: SpeechCommandWords.toGlass, notification: .toGlass)
        result.append(command)
        
        command = WordCommandAndNotification(command: "DIME", words: SpeechCommandWords.toDime, notification: .toDime)
        result.append(command)
        
        command = WordCommandAndNotification(command: "BAD", words: SpeechCommandWords.toBad, notification: .toBad)
        result.append(command)
        
        command = WordCommandAndNotification(command: "STEAL", words: SpeechCommandWords.toSteal, notification: .toSteal)
        result.append(command)
        
        command = WordCommandAndNotification(command: "BLOCK", words: SpeechCommandWords.toBlock, notification: .toBlock)
        result.append(command)
        
        command = WordCommandAndNotification(command: "TIP", words: SpeechCommandWords.toTip, notification: .toTip)
        result.append(command)
        
        command = WordCommandAndNotification(command: "CHARGE", words: SpeechCommandWords.toCharge, notification: .toCharge)
        result.append(command)
        
        return result
    }

    func speechRecognize(onlyMyWord: Bool=false) {}
    func stop() {}
    
    func isSceneRight() -> Bool {
        return true
    }
    
    var delegate: IsPlayerORCommandMeDelegate?
}

public class SpeechToMe13: SpeechToMe, SFSpeechRecognizerDelegate {
    func checkSpeechAuthorization(andThen f: (() -> ())?) {
        print("checking speech authorization")
        let status = SFSpeechRecognizer.authorizationStatus()
        switch status {
        case .notDetermined:
            SFSpeechRecognizer.requestAuthorization {status2 in
                if status2 == .authorized {
                    DispatchQueue.main.async {
                        f?()
                    }
                }
            }
        case .authorized:
            f?()
        default:
            print("no authorization")
            break
        }
    }
    
    func checkMicAuthorization(andThen f: (() -> ())?) {
        print("checking mic authorization")
        let sess = AVAudioSession.sharedInstance()
        let status = sess.recordPermission
        switch status {
        case .undetermined:
            sess.requestRecordPermission {ok in
                if ok {
                    DispatchQueue.main.async {
                        f?()
                    }
                }
            }
        case .granted:
            f?()
        default:
            print("no microphone")
            break
        }
    }
    
    let engine = AVAudioEngine()
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    override func speechRecognize(onlyMyWord: Bool=false) {
        self.checkSpeechAuthorization(andThen:alsoCheckMic)
    }
    
    func alsoCheckMic() {
        self.checkMicAuthorization(andThen:reallyDoLive)
    }
    
    func reallyDoLive() {
        // same as before, basically
        let loc = Locale.current
        
        guard let rec = SFSpeechRecognizer(locale:loc)
            else {print("no recognizer"); return}
        print("rec isAvailable says: \(rec.isAvailable)")
        
        // Cancel the previous task if it's running.
        if self.recognitionTask != nil {
            // 停止前面的
            self.stop()
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        if #available(iOS 13, *) {
            if rec.supportsOnDeviceRecognition {
                print("on device recognition")
                self.recognitionRequest!.requiresOnDeviceRecognition = true
            } else {
                print("no on device recognition")
            }
        } else {
            // Fallback on earlier versions
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(AVAudioSession.Category.record)
        try? audioSession.setMode(AVAudioSession.Mode.measurement)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // tap into microphone thru audio engine!
        let inputNode = self.engine.inputNode
        inputNode.installTap(onBus: 0, bufferSize: 4096, format: inputNode.outputFormat(forBus: 0)) {
            buffer, time in
            self.recognitionRequest!.append(buffer)
        }
        self.engine.prepare()
        try! self.engine.start()
        // same as before
        print("starting live recognition")
        
        // 避免重复
        var lastWord = ""
        var lastTime = Date()
        
        self.recognitionTask = rec.recognitionTask(with: self.recognitionRequest!) { result, err in
            var isFinal = false
            if let result = result {
                //=========
                let str = result.bestTranscription.formattedString

                let info = "Originally recognized speech text: \(str)"
                print(info)
                
                if self.isSceneRight() == false {
                    // scene
                    isFinal = true
                }
                
                // 顺序：1.myWordCommandAndNotifications
                if self.myWordCommandAndNotifications != nil && isFinal == false {
                    // 遍历：查找声控命令：应用级
                    for myWordCommandAndNotification in self.myWordCommandAndNotifications! {
                        for word in myWordCommandAndNotification.words {
                            print("myWordCommandAndNotification.words")
                            print(word)
                            if containSpeechCommand(strInput: str, word: word) {
                                // 发出通知
                                if isFinal == false {
                                    if word.lowercased() == lastWord.lowercased() {
                                        if lastTime.timeIntervalSinceNow < -2.0 {
                                            // 大于1秒
                                            lastTime = Date()
                                            if SettingsBundleHelper.fetchIsResponseOnSpeechControl() == 0 {
                                                let info = "lastTime.timeIntervalSinceNow < -2.0: " + word
                                                print(info)
                                                // process
                                                if self.saveVoiceCommand(str: str, wcn: myWordCommandAndNotification) {
                                                    NotificationCenter.default.post(name: myWordCommandAndNotification.notification, object: self)
                                                    NotificationCenter.default.post(name: .commandSuccess, object: self)
                                                }
                                            }
                                        }
                                    } else {
                                        lastWord = word.lowercased()
                                        lastTime = Date()
                                        if SettingsBundleHelper.fetchIsResponseOnSpeechControl() == 0 {
                                            let info = "lastWord = word: " + word
                                            print(info)
                                            
                                            // process
                                            if self.saveVoiceCommand(str: str, wcn: myWordCommandAndNotification) {
                                                NotificationCenter.default.post(name: myWordCommandAndNotification.notification, object: self)
                                                NotificationCenter.default.post(name: .commandSuccess, object: self)
                                            }
                                            
                                        }
                                    }
                                }

                                isFinal = true
                                
                                break
                            }
                        }
                        
                        if isFinal {
                            break
                        }
                    }
                }
                
                if isFinal {
                    let info = "结束：isFinal Stop Recording"
                    print(info)
                    
                    // 结束
                    /*
                    if SettingsBundleHelper.fetchIsResponseOnSpeechControl() == 0 {
                        self.stop()
                    } else if self.isSceneRight() == false {
                        self.stop()
                    }
                    */
                }

                
            } else {
                // with on device recognition I always get error 203 when we stop
                // but I don't think that's of any importance
                print(err!)
                // 结束
                self.stop()
            }
        }
    }
    
    // this is why req is a property: we need a way to stop it
    override func stop() {
        self.engine.stop()
        self.engine.inputNode.removeTap(onBus: 0) // otherwise cannot start again
        self.engine.inputNode.reset()
        
        self.recognitionRequest?.endAudio()
        self.recognitionTask?.cancel()
        self.recognitionTask?.finish()
        self.recognitionRequest = nil
        self.recognitionTask = nil
    }
    
    // up to 5 words
    let upToNumber = 2
    
    /// (number, command)
    /// (player, command)
    func saveVoiceCommand(str: String, wcn: WordCommandAndNotification) -> Bool {
        // number, word
        let arr = str.split(separator: " ")
        if arr.count < 2 {
            return false
        }
        
        let count = arr.count
        var counter = 0
        for index in 1..<count {
            let tmp = arr[count - 1 - index]
            let str_tmp = String(tmp).lowercased()
            
            print(str_tmp)
            /*
            if let aInt = Int(str_tmp) {
                // number
                print("number: \(aInt),\(wcn.command)")
                let voiceCommand = "\(aInt) \(wcn.command.uppercased())"
                SettingsBundleHelper.saveRecognizeVoiceCommand(voiceCommand)
                return true
            } else {
                // player
                if let player = self.delegate!.isPlayer(str_tmp) {
                    // player
                    print("player: \(str_tmp),\(wcn.command)")
                    let voiceCommand = "\(player.capitalized) \(wcn.command.uppercased())"
                    SettingsBundleHelper.saveRecognizeVoiceCommand(voiceCommand)
                    return true
                }
            }
            */
            
            
            if let aInt = self.delegate!.isNumber(str_tmp) {
                // number
                print("number: \(aInt),\(wcn.command)")
                let voiceCommand = "\(aInt) \(wcn.command.uppercased())"
                SettingsBundleHelper.saveRecognizeVoiceCommand(voiceCommand)
                return true
            } else {
                // player
                if let player = self.delegate!.isPlayer(str_tmp) {
                    // player
                    print("player: \(str_tmp),\(wcn.command)")
                    let voiceCommand = "\(player.capitalized) \(wcn.command.uppercased())"
                    SettingsBundleHelper.saveRecognizeVoiceCommand(voiceCommand)
                    return true
                }
            }
            
            // If it's a number, but not a player's number, then exit
            if Int(str_tmp) != nil {
                break
            }

            
            counter += 1
            
            if counter >= upToNumber {
                break
            }
        }
        
        return false
    }
    
    func isPlayer(_ word: String) -> String? {
        guard self.playerVoiceWords != nil else {
            return nil
        }
        print("isPlayer(_ word: String)  \(word)")
        for pvw in self.playerVoiceWords! {
            print(pvw.player)
            if pvw.player.lowercased() == word {
                return pvw.player
            }
            
            for tmp in pvw.words {
                print(tmp)
                if tmp == word {
                    return pvw.player
                }
            }
        }
        return nil
    }
}

protocol IsPlayerORCommandMeDelegate: AnyObject {
    func isPlayer(_ word: String) -> String?
    func isNumber(_ word: String) -> String?
    func isCommand(_ word: String) -> Bool
}

extension MainViewController: IsPlayerORCommandMeDelegate {
    func isPlayer(_ word: String) -> String? {
        guard self.playerVoiceWords != nil else {
            return nil
        }
        
        for pvw in self.playerVoiceWords! {
            if pvw.player.lowercased() == word {
                return pvw.player
            }
            
            if pvw.words.contains(word) {
                return pvw.player
            }
        }
        return nil
    }
    
    func isNumber(_ word: String) -> String? {
        guard self.numberVoiceWords != nil else {
            return nil
        }
        
        for nvw in self.numberVoiceWords! {
            if nvw.number == word {
                return nvw.number
            }
            
            if nvw.words.contains(word) {
                return nvw.number
            }
        }
        return nil
    }
    
    func isCommand(_ word: String) -> Bool {
        
        return false
    }
}
