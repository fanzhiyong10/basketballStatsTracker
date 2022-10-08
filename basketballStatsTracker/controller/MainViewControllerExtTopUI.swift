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
    }
    
    /// 开始听取指令
    @objc func voiceListen() {
        var color = UIColor.systemGray
        if voiceListeningStart {
            // status: 启动 -> 停止
            voiceListeningStart = false
            color = UIColor.systemGray
        } else {
            // status: 停止 -> 启动
            voiceListeningStart = true
            color = UIColor.systemGreen
        }
        let image = UIImage(systemName: "mic.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 64)))?.withTintColor(color, renderingMode: .alwaysOriginal)
        self.micImageView.image = image

    }
    
    /// top center
    ///
    /// time
    /// - Game Clock
    /// - start button
    /// - stop button
    func createTopCenter() {
        // voice to text
        self.gameClockLabel = UILabel()
        self.gameClockLabel.text = "Game Clock: 23m:45s"
        self.gameClockLabel.font = UIFont.systemFont(ofSize: 36)
        self.gameClockLabel.textColor = UIColor.systemGreen
        self.gameClockLabel.textAlignment = .center
        self.topContentView.addSubview(self.gameClockLabel)
        
        self.gameClockLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.gameClockLabel.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.gameClockLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            self.gameClockLabel.widthAnchor.constraint(equalToConstant: 400),
            self.gameClockLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // start button
        let image = UIImage(named: "start")
        self.startButton = UIButton()
        self.startButton.setImage(image, for: .normal)
        self.topContentView.addSubview(self.startButton)
        
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.startButton.leadingAnchor.constraint(equalTo: safe.centerXAnchor, constant: -180),
            self.startButton.topAnchor.constraint(equalTo: self.gameClockLabel.bottomAnchor, constant: 12),
            self.startButton.widthAnchor.constraint(equalToConstant: 50),
            self.startButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // stop button
        let image_stop = UIImage(named: "stop")
        self.stopButton = UIButton()
        self.stopButton.setImage(image_stop, for: .normal)
        self.topContentView.addSubview(self.stopButton)
        
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
    /// players
    /// - Game Clock
    /// - start button
    /// - stop button
    func createTopRight() {
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
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.playersButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
            self.playersButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 30),
            self.playersButton.widthAnchor.constraint(equalToConstant: 190),
            self.playersButton.heightAnchor.constraint(equalToConstant: 60),
        ])
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
//        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
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
