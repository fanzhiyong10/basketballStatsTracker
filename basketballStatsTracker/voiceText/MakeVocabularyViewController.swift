//
//  MakeVocabularyViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/11.
//

import UIKit

extension Notification.Name {
    static let toUpdateNumberVoiceWords = Notification.Name("toUpdateNumberVoiceWords")
    static let toUpdatePlayerVoiceWords = Notification.Name("toUpdatePlayerVoiceWords")
}

let commandHeader = "speechComandWords_"
let numberHeader = "numberVoiceWords_"
let playerHeader = "playerVoiceWords_"

class MakeVocabularyViewController: UIViewController, UITextViewDelegate {
    
    var indexPath: IndexPath?
    var speechComandWords: String?

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let isEmpty = self.commandTV?.text.isEmpty, isEmpty == true {
            self.commandTV?.text = "Voice Command Set" // Placeholder
            self.commandTV?.textColor = UIColor.lightGray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemGray6
        self.overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        self.createNavigatorBar()
        
        self.createInterface()
        
        self.loadData()
    }
    
    var wordSet_init: Set<String>? // 以前保存的

    func loadData() {
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
            if let set = wordSet_init, set.count > 0  {
                self.commandTV.text = result
                self.commandTV.textColor = .black
            }
        }
    }
    
    var commandTV: UITextView! // set of all

    func createInterface() {
        let font = UIFont.systemFont(ofSize: 17)
        
        // label: note
        let noteLabel = UILabel()
        noteLabel.text = "Words are not case sensitive, Use comma \",\" to separate words"
        noteLabel.textAlignment = .left
        noteLabel.font = font
        noteLabel.textColor = .darkGray
        
        self.view.addSubview(noteLabel)
        
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            noteLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
            noteLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            noteLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // set of all
        self.commandTV = UITextView()
        self.commandTV.text = "Voice Command Set"
        self.commandTV.font = UIFont.systemFont(ofSize: 20)
        self.commandTV.textColor = .lightGray
        self.commandTV.delegate = self
        
        self.view.addSubview(self.commandTV)
        
        self.commandTV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.commandTV.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 12),
            self.commandTV.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            self.commandTV.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
            self.commandTV.heightAnchor.constraint(equalToConstant: 175),
        ])
    }
    
    func createNavigatorBar() {
        let image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        
        let close_item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeWindow))
        self.navigationItem.leftBarButtonItem = close_item
        
        
        // ===== right
        let title = NSMutableAttributedString(string:"DONE", attributes:[
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ])
        let aRect = CGRect(origin: CGPoint(), size: CGSize(width: 80, height: 30))
        let doneButton = UIButton(frame: aRect)
        doneButton.contentHorizontalAlignment = .right
        doneButton.setAttributedTitle(title, for: .normal)
        
        doneButton.addTarget(self, action: #selector(doneSelected), for: .touchUpInside)
        
        let done_item = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = done_item
    }
    
    @objc func closeWindow() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    var doneIsRight = false // selected player is right
    
    /// Done
    ///
    /// action
    /// 1. 验证选中的是5个，如果不是5个，则提示弹窗，继续选择
    @objc func doneSelected() {
        
        guard let tmp = self.commandTV.text else {
            return
        }
        
        let result = tmp.lowercased()
        
        // 命令集合处理
        let strs = result.split(separator: ",")
        
        var wordSet = Set<String>()

        for str in strs {
            wordSet.insert(String(str))
        }
        
        var words = ""
        for (index, word) in wordSet.enumerated() {
            words.append(word)
            if index < wordSet.count - 1 {
                words.append(",")
            }
        }
        // 存储到本地
        UserDefaults.standard.set(words, forKey: self.speechComandWords!)
        
        // Notification
        if speechComandWords!.hasPrefix(numberHeader) {
            NotificationCenter.default.post(name: .toUpdateNumberVoiceWords, object: self)
        } else if speechComandWords!.hasPrefix(playerHeader) {
            NotificationCenter.default.post(name: .toUpdatePlayerVoiceWords, object: self)
        }
        
        
/*
        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        */
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        /*
        if let count = self.liveData?.steals_count, count < 0 {
            return false
        }
        */
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Steals cannot be less than 0"
            let message = ""
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.overrideUserInterfaceStyle = .light
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
