//
//  SetGameClockViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetGameClockViewController: UIViewController, UITextFieldDelegate {
    // data
    var game_time_remaining: Float = 48 * 60 // seconds
    private var minutes: Int = 48
    private var seconds: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Game Clock"

        // Do any additional setup after loading the view.
        self.createNavigatorBar()
        
        self.processData()
        
        self.createInterface()
    }
    
    func processData() {
        self.minutes = Int(self.game_time_remaining / 60)
        self.seconds = Int(self.game_time_remaining - Float(self.minutes * 60))
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    var minutesTF: UITextField!
    var secondsTF: UITextField!
    /// Game Clock
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: minutes, seconds
        let minutesLabel = UILabel()
        minutesLabel.text = "Minutes ( 0 ~ 59 )"
        minutesLabel.textAlignment = .center
        minutesLabel.font = font
        minutesLabel.textColor = .black
        
        self.view.addSubview(minutesLabel)
        
        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
        var safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            minutesLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            minutesLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
            minutesLabel.widthAnchor.constraint(equalToConstant: 200),
            minutesLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let secondsLabel = UILabel()
        secondsLabel.text = "Seconds ( 0 ~ 59 )"
        secondsLabel.textAlignment = .center
        secondsLabel.font = font
        secondsLabel.textColor = .black
        
        self.view.addSubview(secondsLabel)
        
        secondsLabel.translatesAutoresizingMaskIntoConstraints = false
        safe = minutesLabel.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            secondsLabel.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            secondsLabel.leadingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 50),
            secondsLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            secondsLabel.heightAnchor.constraint(equalTo: safe.heightAnchor)
        ])
        
        // The range of minutes is
        let minutesTF = UITextField()
        minutesTF.text = "\(minutes)"
        minutesTF.placeholder = "value is 0~59"
        minutesTF.textAlignment = .center
        minutesTF.font = fontTF
        minutesTF.textColor = .systemRed
        minutesTF.adjustsFontSizeToFitWidth = true
        minutesTF.minimumFontSize = 17
        minutesTF.keyboardType = .asciiCapableNumberPad
        minutesTF.delegate = self
        
        self.minutesTF = minutesTF
        self.view.addSubview(minutesTF)
        
        minutesTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minutesTF.topAnchor.constraint(equalTo: safe.bottomAnchor, constant: 12),
            minutesTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            minutesTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            minutesTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let secondsTF = UITextField()
        secondsTF.text = "\(seconds)"
        secondsTF.placeholder = "value is 0~59"
        secondsTF.textAlignment = .center
        secondsTF.font = fontTF
        secondsTF.textColor = .systemRed
        secondsTF.adjustsFontSizeToFitWidth = true
        secondsTF.minimumFontSize = 17
        secondsTF.keyboardType = .asciiCapableNumberPad
        secondsTF.delegate = self

        self.secondsTF = secondsTF
        self.view.addSubview(secondsTF)
        
        secondsTF.translatesAutoresizingMaskIntoConstraints = false
        safe = minutesTF.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            secondsTF.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            secondsTF.leadingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 50),
            secondsTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            secondsTF.heightAnchor.constraint(equalTo: safe.heightAnchor)
        ])
        
        // colon
        let colonLabel = UILabel()
        colonLabel.text = ":"
        colonLabel.textAlignment = .center
        colonLabel.font = fontTF
        colonLabel.textColor = .systemRed
        
        self.view.addSubview(colonLabel)
        
        colonLabel.translatesAutoresizingMaskIntoConstraints = false
        safe = minutesTF.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            colonLabel.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            colonLabel.centerXAnchor.constraint(equalTo: safe.trailingAnchor, constant: 25),
            colonLabel.widthAnchor.constraint(equalToConstant: 30),
            colonLabel.heightAnchor.constraint(equalTo: safe.heightAnchor)
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
        guard let tmp_m = self.minutesTF.text, let mins = Int(tmp_m) else {
            return
        }
        
        guard let tmp_s = self.secondsTF.text, let secs = Int(tmp_s) else {
            return
        }

        self.minutes = mins
        self.seconds = secs

        guard self.validSelect() else {
            // alert selected error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        guard (0...59).contains(self.minutes) else {
            return false
        }
        guard (0...59).contains(self.seconds) else {
            return false
        }
        
        guard self.minutes + self.seconds > 0 else {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Wrong Game Clock"
            let message = "1) Game Clock must be greater than 0. \n2) Minutes' value is 0~59.\n3) Seconds' value is 0~59"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.overrideUserInterfaceStyle = .light
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    weak var delegate: SetGameClockDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetGameClock(minutes, seconds)
        }
    }


}


protocol SetGameClockDelegate: AnyObject {
    func doSetGameClock(_ minutes: Int, _ seconds: Int)
}

extension MainViewController: SetGameClockDelegate {
    func doSetGameClock(_ minutes: Int, _ seconds: Int) {
        DispatchQueue.main.async {
            self.game_time_remaining = Float(minutes * 60 + seconds)
            
            // modify show
            let title = self.processGameClockTitle()
            self.gameClockButton.setAttributedTitle(title, for: .normal)
        }
    }
}
