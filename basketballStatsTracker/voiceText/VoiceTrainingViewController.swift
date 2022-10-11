//
//  VoiceTrainingViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/9.
//

import UIKit

extension Notification.Name {
    // 声控训练：语音识别
    static let wordOfTrainSpeechRecognize = Notification.Name("wordOfTrainSpeechRecognize")
}

class VoiceTrainingViewController: UIViewController {

    var indexPath: IndexPath?
    var speechComandWords: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.overrideUserInterfaceStyle = .light
        
        // Do any additional setup after loading the view.
        // 声控训练：语音识别
        NotificationCenter.default.addObserver(self, selector: #selector(wordOfTrainSpeechRecognize), name: .wordOfTrainSpeechRecognize, object: nil)
        
        self.createInterface()
        
        self.setup()
        
        self.trainSpeechRecognize = TrainSpeechRecognize13()
    }
    
    @objc func wordOfTrainSpeechRecognize() {
        print("wordOfTrainSpeechRecognize()")
        guard let word = SettingsBundleHelper.fetchWordOfTrainSpeechRecognize() else { return  }
        
        self.recognizeWords.text = word

        wordArray.append(word)
        
        var str = ""
        for (index,word) in wordArray.enumerated() {
            str.append(word)
            
            if index < wordArray.count - 1 {
                str.append(",")
            }
        }
        self.wordText.text = str
        print(word)
        
        // ===== 命令集合
        self.wordSet = Set(self.wordArray)
        self.wordSet_all = Set(self.wordArray)
        if self.wordSet_init != nil {
            self.wordSet_all = self.wordSet_init
            self.wordSet_all = self.wordSet_all?.union(self.wordSet!)
        } else {
            self.wordSet_all = self.wordSet
        }

        do {
            var str = ""
            for (index,word) in self.wordSet_all!.enumerated() {
                str.append(word)
                
                if index < self.wordSet_all!.count - 1 {
                    str.append(",")
                }
            }
            self.commandText.text = str
            
            // 存储到本地
            UserDefaults.standard.set(str, forKey: self.speechComandWords!)
        }
    }
    
    func setup() {
        guard self.speechComandWords != nil else {
            return
        }
        
        // 读出存储的命令集合
        if let result = UserDefaults.standard.string(forKey: self.speechComandWords!) {
            // 命令集合处理
            let strs = result.split(separator: ",")
            if self.wordSet_init == nil {
                self.wordSet_init = Set<String>()
            }
            
            for str in strs {
                wordSet_init?.insert(String(str))
            }
            
            // 命令集合显示
            self.commandText.text = result
        }
    }
    
    /// user interface
    ///
    /// include:
    /// - top: note
    /// - button: begin, end
    /// - word, set of this time, set of all (previous, this time)
    /// - delete: previous, this time, all
    func createInterface() {
        self.createContentView()
        self.createNotes()
        self.createBeginAndEndButtons()
        self.createWordAndSets()
        self.createDeleteButtons()
    }
    
    var contentView: UIView!
    func createContentView() {
        self.contentView = UIView()
//        self.contentView.backgroundColor = .white
        self.view.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            self.contentView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
            self.contentView.widthAnchor.constraint(equalToConstant: 610),
            self.contentView.heightAnchor.constraint(equalToConstant: 700),
        ])
    }
    
    var note1Label: UILabel!
    var note2Label: UILabel!
    
    /// notes
    func createNotes() {
        let font = UIFont.systemFont(ofSize: 17)
        // note1
        self.note1Label = UILabel()
        self.note1Label.text = "Training can improve the accuracy of voice control."
        self.note1Label.textColor = .darkGray
        self.note1Label.font = font
        self.contentView.addSubview(self.note1Label)
        
        self.note1Label.translatesAutoresizingMaskIntoConstraints = false
        var safe = self.contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.note1Label.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0),
            self.note1Label.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.note1Label.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.note1Label.heightAnchor.constraint(equalToConstant: 31),
        ])
        
        // note2
        self.note2Label = UILabel()
        self.note2Label.text = "◇ Repeat reading, at least 3 times."
        self.note2Label.textColor = .darkGray
        self.note2Label.font = font
        self.contentView.addSubview(self.note2Label)
        
        self.note2Label.translatesAutoresizingMaskIntoConstraints = false
        safe = self.note1Label.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.note2Label.topAnchor.constraint(equalTo: safe.bottomAnchor, constant: 0),
            self.note2Label.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            self.note2Label.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            self.note2Label.heightAnchor.constraint(equalTo: safe.heightAnchor),
        ])
    }
    
    var beginButton: UIButton! // 按钮：开始
    var endButton: UIButton! // 按钮：结束
    
    /// buttons: begin, end
    func createBeginAndEndButtons() {
        let bigfont = UIFont.systemFont(ofSize: 32)
        
        // begin button
        let para = NSMutableParagraphStyle()
        para.alignment = .left
        let attributedText_begin = NSMutableAttributedString(string: "Start Training", attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.paragraphStyle: para])
        
        self.beginButton = UIButton()
        self.beginButton.setAttributedTitle(attributedText_begin, for: .normal)
        self.contentView.addSubview(self.beginButton)
        
        self.beginButton.addTarget(self, action: #selector(speakWords), for: .touchUpInside)
        
        self.beginButton.translatesAutoresizingMaskIntoConstraints = false
        var safe = self.contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.beginButton.topAnchor.constraint(equalTo: self.note2Label.bottomAnchor, constant: 20),
            self.beginButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.beginButton.widthAnchor.constraint(equalToConstant: 200),
            self.beginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // end button
        para.alignment = .right
        let attributedText_end = NSMutableAttributedString(string: "Stop Training", attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.paragraphStyle: para])
        self.endButton = UIButton()
        self.endButton.setAttributedTitle(attributedText_end, for: .normal)
        self.contentView.addSubview(self.endButton)
        
        self.endButton.addTarget(self, action: #selector(endSpeech), for: .touchUpInside)
        
        self.endButton.translatesAutoresizingMaskIntoConstraints = false
        safe = self.beginButton.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.endButton.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: 0),
            self.endButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.endButton.widthAnchor.constraint(equalTo: safe.widthAnchor),
            self.endButton.heightAnchor.constraint(equalTo: safe.heightAnchor),
        ])
    }
    
    var recognizeWords: UILabel! // 识别出的文字
    var wordText: UITextView! // 本次识别的文字集合
    var commandText: UITextView! // set of all
    
    /// word, set of this time, set of all (previous, this time)
    func createWordAndSets() {
        let font = UIFont.systemFont(ofSize: 24, weight: .bold)
        // recognizeWords
        self.recognizeWords = UILabel()
        self.recognizeWords.text = "recognized word"
        self.recognizeWords.textColor = .systemGreen
        self.recognizeWords.font = font
        self.recognizeWords.textAlignment = .center
        self.contentView.addSubview(self.recognizeWords)
        
        self.recognizeWords.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.recognizeWords.topAnchor.constraint(equalTo: self.beginButton.bottomAnchor, constant: 20),
            self.recognizeWords.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.recognizeWords.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.recognizeWords.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // current set label
        let currentSetLabel = UILabel()
        currentSetLabel.text = "Now Recognized Words"
        currentSetLabel.textColor = .darkGray
        currentSetLabel.font = UIFont.systemFont(ofSize: 17)
        currentSetLabel.textAlignment = .left
        self.contentView.addSubview(currentSetLabel)
        
        currentSetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentSetLabel.topAnchor.constraint(equalTo: self.recognizeWords.bottomAnchor, constant: 8),
            currentSetLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            currentSetLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            currentSetLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // set of this time
        self.wordText = UITextView()
        self.wordText.text = "The words recognized now:"
        self.wordText.font = UIFont.systemFont(ofSize: 20)
        self.contentView.addSubview(self.wordText)
        
        self.wordText.isUserInteractionEnabled = false
        
        self.wordText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.wordText.topAnchor.constraint(equalTo: currentSetLabel.bottomAnchor, constant: 4),
            self.wordText.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.wordText.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.wordText.heightAnchor.constraint(equalToConstant: 140),
        ])
        
        // all set label
        let allSetLabel = UILabel()
        allSetLabel.text = "All Words (History + Now)"
        allSetLabel.textColor = .darkGray
        allSetLabel.font = UIFont.systemFont(ofSize: 17)
        allSetLabel.textAlignment = .left
        self.contentView.addSubview(allSetLabel)
        
        allSetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allSetLabel.topAnchor.constraint(equalTo: self.wordText.bottomAnchor, constant: 12),
            allSetLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            allSetLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            allSetLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // set of all
        self.commandText = UITextView()
        self.commandText.text = "Voice Command Set (History + Now)"
        self.commandText.font = UIFont.systemFont(ofSize: 20)
        self.contentView.addSubview(self.commandText)
        
        self.commandText.isUserInteractionEnabled = false
        
        self.commandText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.commandText.topAnchor.constraint(equalTo: allSetLabel.bottomAnchor, constant: 4),
            self.commandText.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.commandText.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.commandText.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    var removeInitButton: UIButton! // 按钮：删除以前
    var removeCurrentButton: UIButton! // 按钮：删除本次
    var removeAllButton: UIButton! // 按钮：删除所有
    
    /// delete buttons: previous, this time, all
    func createDeleteButtons() {
        let bigfont = UIFont.systemFont(ofSize: 24)
        
        // delete previous button
        let para = NSMutableParagraphStyle()
        para.alignment = .left
        let attributedText_previous = NSMutableAttributedString(string: "Remove History", attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.paragraphStyle: para])
        
        self.removeInitButton = UIButton()
        self.removeInitButton.setAttributedTitle(attributedText_previous, for: .normal)
        
        self.contentView.addSubview(self.removeInitButton)
        
        self.removeInitButton.addTarget(self, action: #selector(cleanWords), for: .touchUpInside)
        
        self.removeInitButton.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.removeInitButton.topAnchor.constraint(equalTo: self.commandText.bottomAnchor, constant: 30),
            self.removeInitButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.removeInitButton.widthAnchor.constraint(equalToConstant: 180),
            self.removeInitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // delete current button
        para.alignment = .center
        let attributedText_current = NSMutableAttributedString(string: "Remove Now", attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.paragraphStyle: para])
        self.removeCurrentButton = UIButton()
        self.removeCurrentButton.setAttributedTitle(attributedText_current, for: .normal)
        
        self.contentView.addSubview(self.removeCurrentButton)
        
        self.removeCurrentButton.addTarget(self, action: #selector(cleanWordsCurrent), for: .touchUpInside)
        
        self.removeCurrentButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.removeCurrentButton.centerYAnchor.constraint(equalTo: self.removeInitButton.centerYAnchor, constant: 0),
            self.removeCurrentButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor, constant: 0),
            self.removeCurrentButton.widthAnchor.constraint(equalTo: self.removeInitButton.widthAnchor),
            self.removeCurrentButton.heightAnchor.constraint(equalTo: self.removeInitButton.heightAnchor),
        ])
        
        // delete previous button
        para.alignment = .right
        let attributedText_all = NSMutableAttributedString(string: "Remove All", attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.paragraphStyle: para])
        self.removeAllButton = UIButton()
        self.removeAllButton.setAttributedTitle(attributedText_all, for: .normal)
        
        self.contentView.addSubview(self.removeAllButton)
        
        self.removeAllButton.addTarget(self, action: #selector(cleanWordsAll), for: .touchUpInside)
        
        self.removeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.removeAllButton.centerYAnchor.constraint(equalTo: self.removeInitButton.centerYAnchor, constant: 0),
            self.removeAllButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.removeAllButton.widthAnchor.constraint(equalTo: self.removeInitButton.widthAnchor),
            self.removeAllButton.heightAnchor.constraint(equalTo: self.removeInitButton.heightAnchor),
        ])
        
    }
    
    var number = 3 // 入参
    var wordSet: Set<String>? // 本次识别的
    var wordSet_init: Set<String>? // 以前保存的
    var wordSet_all: Set<String>? // 所有
    var wordArray = [String]()
    

    var trainSpeechRecognize: TrainSpeechRecognize?

    @objc func speakWords(_ sender: Any) {
        let bigfont = UIFont.systemFont(ofSize: 20)
        let fontColor = UIColor.systemRed
        let attributedText = NSMutableAttributedString(string: "Now is training...", attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: fontColor])
        self.beginButton.setTitleColor(.red, for: .normal)
        self.beginButton.setAttributedTitle(attributedText, for: .normal)
        self.beginButton.isUserInteractionEnabled = false
        
        // 参数：字长
        trainSpeechRecognize?.number = number
        
        // 启动
        trainSpeechRecognize?.speechRecognize()
    }

    @objc func endSpeech(_ sender: Any) {
        self.trainSpeechRecognize?.stop()
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    private func setToString(_ wordSet: Set<String>) -> String {
        var str = ""
        for (index,word) in wordSet.enumerated() {
            str.append(word)
            
            if index < wordSet.count - 1 {
                str.append(",")
            }
        }
        
        return str
    }
    
    private func stringToSet(_ result: String) -> Set<String>? {
        guard result != "" else {
            return nil
        }
        var wordSet = Set<String>()
        let strs = result.split(separator: ",")
        
        for str in strs {
            wordSet.insert(String(str))
        }
        
        return wordSet
    }
    
    @objc func cleanWords(_ sender: Any) {
        // wordSet_init
        self.wordSet_init = nil
        
        guard self.wordSet != nil else {
            self.wordSet_all = nil
            
            self.commandText.text = "Voice Command Set (History + Now)"

            UserDefaults.standard.set(nil, forKey: self.speechComandWords!)
            return
        }
        
        // 重新赋值wordSet_all
        self.wordSet_all = self.wordSet
        
        // 文字处理
        let strs = self.setToString(self.wordSet_all!)
        
        // 命令集合：显示
        self.commandText.text = strs
        
        // 存储到本地
        UserDefaults.standard.set(strs, forKey: self.speechComandWords!)
    }
    
    @objc func cleanWordsCurrent(_ sender: Any) {
        print("cleanWordsCurrent")
        // wordSet
        // wordArray
        self.wordSet = nil
        self.wordArray = []
        
        guard self.wordSet_init != nil else {
            // 本次识别的文字集合：情况
//            self.wordText.text = "本次识别的文字集合"
            do {
                let s0 = "本次识别的文字集合："
                let s0_loc = NSLocalizedString(s0, tableName: "speechControl", value: s0, comment: s0)
                self.wordText.text = "The words recognized now:"
            }

            // 若以前没有
            self.wordSet_all = nil
            
            // 显示：
//            self.commandText.text = "命令集合"
            do {
                let s0 = "Voice Command Set (History + Now)"
                let s0_loc = NSLocalizedString(s0, tableName: "speechControl", value: s0, comment: s0)
                self.commandText.text = "Voice Command Set (History + Now)"
            }

            // 存储
            UserDefaults.standard.set(nil, forKey: self.speechComandWords!)
            return
        }
        
        // 本次识别的文字集合：情况
//        self.wordText.text = "本次识别的文字集合"
        do {
            let s0 = "本次识别的文字集合："
            let s0_loc = NSLocalizedString(s0, tableName: "speechControl", value: s0, comment: s0)
            self.wordText.text = "The words recognized now:"
        }

        // ========= 重新赋值wordSet_all
        self.wordSet_all = self.wordSet_init
        
        // 文字处理
        let strs = self.setToString(self.wordSet_all!)
        
        // 命令集合：显示
        self.commandText.text = strs
        
        // 存储到本地
        UserDefaults.standard.set(strs, forKey: self.speechComandWords!)
    }
    
    @objc func cleanWordsAll(_ sender: Any) {
        print("cleanWordsAll")
        
        // wordSet_init
        self.wordSet_init = nil
        
        // wordSet
        // wordArray
        self.wordSet = nil
        self.wordArray = []
        
        // 本次识别的文字集合
//        self.wordText.text = "本次识别的文字集合"
        do {
            let s0 = "本次识别的文字集合："
            let s0_loc = NSLocalizedString(s0, tableName: "speechControl", value: s0, comment: s0)
            self.wordText.text = "The words recognized now:"
        }


        // 命令集合
        self.wordSet_all = nil
        
        // 显示：命令集合
//        self.commandText.text = "命令集合"
        do {
            let s0 = "命令集合"
            let s0_loc = NSLocalizedString(s0, tableName: "speechControl", value: s0, comment: s0)
            self.commandText.text = "Voice Command Set (History + Now)"
        }

        // 存储
        UserDefaults.standard.set(nil, forKey: self.speechComandWords!)
    }
    
}
