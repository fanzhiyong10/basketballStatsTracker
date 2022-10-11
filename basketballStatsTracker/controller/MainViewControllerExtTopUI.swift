//
//  MainViewControllerExtTopUI.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/7.
//

import UIKit

extension MainViewController {
    /// topContent
    func createTopContentView() {
        self.topContentView = UIView()
        self.topContentView.backgroundColor = .white // white
        self.view.addSubview(self.topContentView)
        
        self.topContentView.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.topContentView.topAnchor.constraint(equalTo: safe.topAnchor),
            self.topContentView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            self.topContentView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            self.topContentView.heightAnchor.constraint(equalToConstant: 130),
        ])
        
    }
    
    /// top left
    ///
    /// voice
    /// - Voice Training
    /// - Voice Button
    /// - voice to text
    func createTopLeft() {
        // Voice Button
        let image = UIImage(systemName: "mic.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 64)))?.withTintColor(UIColor.systemGray, renderingMode: .alwaysOriginal)
        
        self.micImageView = UIImageView(image: image)
        self.topContentView.addSubview(self.micImageView)
        
        // 启动点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(voiceListen))
        self.micImageView.addGestureRecognizer(tap)
        self.micImageView.isUserInteractionEnabled = true
        
        self.micImageView.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.topContentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.micImageView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 50),
            self.micImageView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
        ])
        
        // voice to text
        self.voiceToTextLabel = UILabel()
        self.voiceToTextLabel.text = "“Ben Brick”"
        self.voiceToTextLabel.font = UIFont.systemFont(ofSize: 24)
        self.voiceToTextLabel.textColor = UIColor.systemGreen
        self.voiceToTextLabel.textAlignment = .left
        self.topContentView.addSubview(self.voiceToTextLabel)
        
        self.voiceToTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.voiceToTextLabel.centerYAnchor.constraint(equalTo: self.micImageView.centerYAnchor),
            self.voiceToTextLabel.leadingAnchor.constraint(equalTo: self.micImageView.trailingAnchor, constant: 12),
            self.voiceToTextLabel.widthAnchor.constraint(equalToConstant: 300),
            self.voiceToTextLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // Voice Training
        let voiceTrainingButton = UIButton()
        voiceTrainingButton.setTitle("Voice Training", for: .normal)
        voiceTrainingButton.setTitleColor(.systemBlue, for: .normal)
        self.topContentView.addSubview(voiceTrainingButton)
        
        voiceTrainingButton.addTarget(self, action: #selector(toVoiceTraining), for: .touchUpInside)
        
        voiceTrainingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voiceTrainingButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            voiceTrainingButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            voiceTrainingButton.widthAnchor.constraint(equalToConstant: 140),
            voiceTrainingButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    /// 开始听取指令
    @objc func voiceListen() {
        var color = UIColor.systemGray
        if voiceListeningStart {
            // status: 启动 -> 停止
            voiceListeningStart = false
            color = UIColor.systemGray
            
            self.timerSST?.invalidate()
            self.speechCommand?.stop()
            
            SettingsBundleHelper.saveIsResponseOnSpeechControl(1)
        } else {
            // status: 停止 -> 启动
            voiceListeningStart = true
            color = UIColor.systemGreen
            
            self.voiceToTextLabel.text = ""
            
            self.speechControl()
            
            SettingsBundleHelper.saveIsResponseOnSpeechControl(0)
        }
        let image = UIImage(systemName: "mic.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 64)))?.withTintColor(color, renderingMode: .alwaysOriginal)
        self.micImageView.image = image

    }
    
    func stopVoiceListening() {
        voiceListeningStart = false
        let color = UIColor.systemGray
        
        self.timerSST?.invalidate()
        self.speechCommand?.stop()
        
        SettingsBundleHelper.saveIsResponseOnSpeechControl(1)
        
        let image = UIImage(systemName: "mic.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 64)))?.withTintColor(color, renderingMode: .alwaysOriginal)
        self.micImageView.image = image
    }
    
    func calGameClock() -> String {
        let mins = Int(self.game_time_remaining / 60)
        let secs = Int(self.game_time_remaining - Float(mins * 60))
        var str = "Game Clock: "
        str += String(format: "%02d", mins) + "m:"
        str += String(format: "%02d", secs) + "s"
        
        return str
    }
    
    func processGameClockTitle() -> NSMutableAttributedString {
        let para = NSMutableParagraphStyle()
        para.alignment = .center
        let title = NSMutableAttributedString(string: self.calGameClock(), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36), NSAttributedString.Key.foregroundColor: UIColor.systemGreen, NSAttributedString.Key.paragraphStyle: para])
        
        return title
    }
    /// top center
    ///
    /// time
    /// - Game Clock
    /// - start button
    /// - stop button
    func createTopCenter() {
        // Game Clock
        let title = self.processGameClockTitle()
        
        self.gameClockButton = UIButton()
        self.gameClockButton.setAttributedTitle(title, for: .normal)
        self.topContentView.addSubview(self.gameClockButton)
        self.gameClockButton.addTarget(self, action: #selector(tapGamClock), for: .touchUpInside)
        
        self.gameClockButton.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.gameClockButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.gameClockButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            self.gameClockButton.widthAnchor.constraint(equalToConstant: 400),
            self.gameClockButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // start button
        let image = UIImage(named: "start")
        self.startButton = UIButton()
        self.startButton.setImage(image, for: .normal)
        self.topContentView.addSubview(self.startButton)
        
        self.startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.startButton.leadingAnchor.constraint(equalTo: safe.centerXAnchor, constant: -180),
            self.startButton.topAnchor.constraint(equalTo: self.gameClockButton.bottomAnchor, constant: 12),
            self.startButton.widthAnchor.constraint(equalToConstant: 50),
            self.startButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // stop button
        let image_stop = UIImage(named: "stop")
        self.stopButton = UIButton()
        self.stopButton.setImage(image_stop, for: .normal)
        self.topContentView.addSubview(self.stopButton)
        
        self.stopButton.isHidden = true
        
        self.stopButton.addTarget(self, action: #selector(stopGame), for: .touchUpInside)
        
        self.stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stopButton.trailingAnchor.constraint(equalTo: safe.centerXAnchor, constant: 180),
            self.stopButton.centerYAnchor.constraint(equalTo: self.startButton.centerYAnchor),
            self.stopButton.widthAnchor.constraint(equalTo: self.startButton.widthAnchor),
            self.stopButton.heightAnchor.constraint(equalTo: self.startButton.heightAnchor),
        ])
    }
    
    /// top right
    ///
    /// content
    /// - New Game
    /// - players
    func createTopRight() {
        // New Game
        let newGameButton = UIButton()
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(.systemBlue, for: .normal)
        self.topContentView.addSubview(newGameButton)
        
        newGameButton.addTarget(self, action: #selector(doNewGame), for: .touchUpInside)
        
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            newGameButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            newGameButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
            newGameButton.widthAnchor.constraint(equalToConstant: 140),
            newGameButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // players
        let title = NSMutableAttributedString(string:"PLAYERS", attributes:[
            .font: UIFont.systemFont(ofSize: 36),
            .foregroundColor: UIColor.white
        ])
        
        self.playersButton = UIButton()
        self.playersButton.setAttributedTitle(title, for: .normal)
        
        self.playersButton.backgroundColor = .systemBlue
        self.playersButton.layer.cornerRadius = 10
        self.playersButton.layer.borderWidth = 2
        self.playersButton.layer.borderColor = UIColor.systemGray.cgColor
        self.topContentView.addSubview(self.playersButton)
        
        self.playersButton.addTarget(self, action: #selector(toSubstitutePlayers), for: .touchUpInside)
        
        self.playersButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.playersButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
            self.playersButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 60),
            self.playersButton.widthAnchor.constraint(equalToConstant: 190),
            self.playersButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    @objc func doNewGame() {
        print("doNewGame")
        
        let liveDatas_previous = self.allLiveDatas
        
        self.allLiveDatas = [LiveData]()
        
        for tmp in liveDatas_previous {
            var ld = LiveData()
            ld.player = tmp.player
            ld.number = tmp.number
            ld.isOnCourt = tmp.isOnCourt
            
            self.allLiveDatas.append(ld)
        }
        
        self.processTotalData()
        
        self.tableView.reloadData()
        
        DispatchQueue.main.async {
            self.game_time_remaining = 40 * 60
            let title = self.processGameClockTitle()
            self.gameClockButton.setAttributedTitle(title, for: .normal)
        }
    }
    
    ///voice training
    ///
    /// guard condition:
    /// - stop voice listening
    @objc func toVoiceTraining() {
        print("toVoiceTraining()")
        
        // guard
        self.stopVoiceListening()
        
        let vc = VoiceTextTableViewController()
        vc.allLiveDatas = self.allLiveDatas
//        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height -= 20
        size.width = 600
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = self.view
            pop.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            pop.permittedArrowDirections = UIPopoverArrowDirection() // 去掉箭头
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }
    
    
    
    @objc func toSubstitutePlayers() {
        let vc = SubstitutePlayersViewController()
        vc.allLiveDatas = self.allLiveDatas
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height -= 20
        size.width = 300
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = self.view
            pop.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            pop.permittedArrowDirections = UIPopoverArrowDirection() // 去掉箭头
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }
    
    @objc func tapGamClock() {
        let vc = SetGameClockViewController()
        vc.game_time_remaining = self.game_time_remaining
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = self.gameClockButton
//            pop.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//            pop.permittedArrowDirections = UIPopoverArrowDirection() // 去掉箭头
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }
}

extension MainViewController : UIPopoverPresentationControllerDelegate {
    func popoverPresentationControllerShouldDismissPopover(
        _ pop: UIPopoverPresentationController) -> Bool {
        // 点击：窗口外部，允许消失
        return pop.presentedViewController.presentedViewController == nil
    }
    
    func popoverPresentationControllerDidDismissPopover(_ pop: UIPopoverPresentationController) {
    }
}


extension MainViewController : UINavigationControllerDelegate {
    // deal with content size change bug
    // this bug is evident when you tap the Change Size row and navigate back:
    // the height doesn't change back
    
    func navigationController(_ nc: UINavigationController, didShow vc: UIViewController, animated: Bool) {
        nc.preferredContentSize = vc.preferredContentSize
    }
    
}
