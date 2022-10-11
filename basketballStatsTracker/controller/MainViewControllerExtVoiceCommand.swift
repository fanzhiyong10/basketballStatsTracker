//
//  MainViewControllerExtVoiceCommand.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

/// Voice Command
extension MainViewController {
    // 语音控制
    func speechControl() {
        self.speechCommand = SpeechToMe13()
        self.speechCommand?.playerVoiceWords = self.playerVoiceWords
        self.speechCommand?.delegate = self
        
        // 启动
        speechCommand?.speechRecognize()
        
        // 避免1分钟
        self.timerSST = Timer.scheduledTimer(timeInterval: 55.0, target: self, selector: #selector(self.fireTime), userInfo: nil, repeats: true)
    }
    
    @objc func fireTime()
    {
        if(startedSTT) {
            let info = "到时，startedSTT == true)"
            print(info)
            self.speechCommand?.stop()
            
            startedSTT = false
        }
        
        // restart it
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startedSTT = true
            
            self.speechCommand = SpeechToMe13()
            self.speechCommand?.playerVoiceWords = self.playerVoiceWords
            self.speechCommand?.delegate = self

            // 启动
            self.speechCommand?.speechRecognize()
        }
    }
    
    func addObserverOfVoiceWordTrain() {
        NotificationCenter.default.addObserver(self, selector: #selector(toUpdateNumberVoiceWords), name: .toUpdateNumberVoiceWords, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toUpdatePlayerVoiceWords), name: .toUpdatePlayerVoiceWords, object: nil)
    }
    
    @objc func toUpdateNumberVoiceWords() {
        self.processNumberVoiceWords()
    }
    
    @objc func toUpdatePlayerVoiceWords() {
        self.processPlayerVoiceWords()
    }
    
    /// Speech Command Observer
    func addSpeechCommand() {
        NotificationCenter.default.addObserver(self, selector: #selector(toMake), name: .toMake, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toMiss), name: .toMiss, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toBucket), name: .toBucket, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toBrick), name: .toBrick, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toSwish), name: .toSwish, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toOff), name: .toOff, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toBoard), name: .toBoard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toGlass), name: .toGlass, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toDime), name: .toDime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toBad), name: .toBad, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toSteal), name: .toSteal, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toBlock), name: .toBlock, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toTip), name: .toTip, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toCharge), name: .toCharge, object: nil)
    }
    
    @objc func toMake() {
        print("toMake()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].ft_make_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].ft_make_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toMiss() {
        print("toMiss()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].ft_miss_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].ft_miss_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toBucket() {
        print("toBucket()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg2_make_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg2_make_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toBrick() {
        print("toBrick()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg2_miss_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg2_miss_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toSwish() {
        print("toSwish()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg3_make_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg3_make_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toOff() {
        print("toOff()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg3_miss_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].fg3_miss_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toBoard() {
        print("toBoard()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].orebs_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].orebs_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toGlass() {
        print("toGlass()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].drebs_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].drebs_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toDime() {
        print("toDime()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].assts_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].assts_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toBad() {
        print("toBad()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].tos_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].tos_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toSteal() {
        print("toSteal()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].steals_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].steals_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toBlock() {
        print("toBlock()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].blocks_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].blocks_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toTip() {
        print("toTip()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].defs_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].defs_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    @objc func toCharge() {
        print("toCharge()")
        
        guard let voiceCommand = SettingsBundleHelper.fetchRecognizeVoiceCommand() else { return }
        
        self.voiceToTextLabel.isHidden = false
        self.voiceToTextLabel.text = "“\(voiceCommand)”"
        delay(2.0) {
            self.voiceToTextLabel.isHidden = true
        }
        
        let arr = voiceCommand.split(separator: " ")
        
        let first = String(arr[0])
        if Int(first) != nil {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.number == first {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].charges_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        } else {
            for (index, liveData) in self.allLiveDatas.enumerated() {
                if liveData.player?.lowercased() == first.lowercased() {
                    DispatchQueue.main.async {
                        self.allLiveDatas[index].charges_count += 1
                        
                        self.tableView.reloadData()
                    }
                    break
                }
            }
        }
    }

}
