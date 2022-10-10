//
//  SetPlayersViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetPlayersViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Player"

        // Do any additional setup after loading the view.
        self.createNavigatorBar()
        
        self.createInterface()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    var playerTF: UITextField!
    
    /// Player
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: minutes, seconds
        let playerLabel = UILabel()
        playerLabel.text = "Player"
        playerLabel.textAlignment = .center
        playerLabel.font = font
        playerLabel.textColor = .darkGray
        
        self.view.addSubview(playerLabel)
        
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            playerLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            playerLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            playerLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            playerLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // The range of minutes is
        let playerTF = UITextField()
        playerTF.text = self.liveData?.player
        playerTF.placeholder = "input player"
        playerTF.textAlignment = .center
        playerTF.font = fontTF
        playerTF.textColor = .systemRed
        playerTF.adjustsFontSizeToFitWidth = true
        playerTF.minimumFontSize = 17
        playerTF.keyboardType = .asciiCapableNumberPad
        playerTF.delegate = self
        
        self.playerTF = playerTF
        self.view.addSubview(playerTF)
        
        playerTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerTF.topAnchor.constraint(equalTo: playerLabel.bottomAnchor, constant: 12),
            playerTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            playerTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            playerTF.heightAnchor.constraint(equalToConstant: 60)
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
        guard let tmp_player = self.playerTF.text, tmp_player.count < 10 else {
            return
        }
        
        self.liveData?.player = tmp_player

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Wrong Player"
            let message = ""
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.overrideUserInterfaceStyle = .light
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    var liveData: LiveData?
    var indexPath: IndexPath?
    weak var delegate: SetPlayersDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetPlayer(liveData!, indexPath!)
        }
    }

}


protocol SetPlayersDelegate: AnyObject {
    func doSetPlayer(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetPlayersDelegate {
    func doSetPlayer(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].player = liveData.player
            
            // modify show
            self.tableView.reloadData()
        }
    }
}
