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
    
    if str.hasSuffix(word) {
        return true
    }
    
    return false
}

struct WordCommandAndNotification {
    // 话语
    var words: [String]
    
    // 通知
    var notification: Notification.Name
}

public class SpeechToMe: NSObject {
    // 话语-通知，入参：使用者传入
    var myWordCommandAndNotifications: [WordCommandAndNotification]? {
        var result = [WordCommandAndNotification]()
        
        var command = WordCommandAndNotification(words: SpeechCommandWords.toMake, notification: .toMake)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toMiss, notification: .toMiss)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toBucket, notification: .toBucket)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toBrick, notification: .toBrick)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toSwish, notification: .toSwish)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toOff, notification: .toOff)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toBoard, notification: .toBoard)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toGlass, notification: .toGlass)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toDime, notification: .toDime)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toBad, notification: .toBad)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toSteal, notification: .toSteal)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toBlock, notification: .toBlock)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toTip, notification: .toTip)
        result.append(command)
        
        command = WordCommandAndNotification(words: SpeechCommandWords.toCharge, notification: .toCharge)
        result.append(command)
        
        return result
    }

    func speechRecognize(onlyMyWord: Bool=false) {}
    func stop() {}
    
    func isSceneRight() -> Bool {
        return true
    }
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

                let info = "语音识别，文字：\(str)"
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
                                                if self.saveVoiceCommand(str: str, word: word) {
                                                    NotificationCenter.default.post(name: myWordCommandAndNotification.notification, object: self)
                                                }
                                            }
                                        }
                                    } else {
                                        lastWord = word
                                        lastTime = Date()
                                        if SettingsBundleHelper.fetchIsResponseOnSpeechControl() == 0 {
                                            let info = "lastWord = word: " + word
                                            print(info)
                                            
                                            // process
                                            if self.saveVoiceCommand(str: str, word: word) {
                                                NotificationCenter.default.post(name: myWordCommandAndNotification.notification, object: self)
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
    
    /// (number, command)
    /// (player, command)
    func saveVoiceCommand(str: String, word: String) -> Bool {
        // number, word
        let arr = str.split(separator: " ")
        if arr.count < 2 {
            return false
        }
        
        let count = arr.count
        for index in 0..<count {
            let tmp = arr[count - 1 - index]
            let str_tmp = String(tmp)
            
            print(str_tmp)
            
            if let aInt = Int(str_tmp) {
                print("number: \(aInt),\(word)")
                let voiceCommand = "\(aInt) \(word)"
                SettingsBundleHelper.saveRecognizeVoiceCommand(voiceCommand)
                return true
            }
        }
        
        return false
    }
}
