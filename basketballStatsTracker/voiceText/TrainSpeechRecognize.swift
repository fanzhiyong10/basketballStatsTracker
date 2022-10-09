//
//  TrainSpeechRecognize.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/9.
//

import Foundation
import Speech
import os.log

public class TrainSpeechRecognize: NSObject {
    var number = 3
    
    var isSceneRight = true
    
    // 结尾标点符号
    let signArr = [".", "。", "?", "？", ",", "，"]
    
    func speechRecognize(onlyMyWord: Bool=false) {}
    func stop() {}
}

public class TrainSpeechRecognize13: TrainSpeechRecognize, SFSpeechRecognizerDelegate {
    
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
//        var lastWord = ""
//        var lastTime = Date()
        
        self.recognitionTask = rec.recognitionTask(with: self.recognitionRequest!) { result, err in
            var isFinal = false
            if let result = result {
                //=========
                var str = result.bestTranscription.formattedString

                let info = "recognized word：\(str)"
                print(info)
                
                // 最后3个字，或2个字
                print(str)
                
                // ==== 调整算法（中英文），去掉结束的标点符号
                if let last = str.last, self.signArr.contains(String(last)) {
                    str.removeLast()
                }
                
                let arr = str.split(separator: " ")
                if let last = arr.last {
                    let word = String(last).lowercased()
                    print(word)
                    // save word
                    SettingsBundleHelper.saveWordOfTrainSpeechRecognize(word)
                    NotificationCenter.default.post(name: .wordOfTrainSpeechRecognize, object: self)
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
    
}
