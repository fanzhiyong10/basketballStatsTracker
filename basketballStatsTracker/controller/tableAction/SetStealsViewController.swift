//
//  SetStealsViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetStealsViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Steals"

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
    
    var stealsTF: UITextField!
    
    /// Steals
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: Steals
        let stealsLabel = UILabel()
        stealsLabel.text = "Steals"
        stealsLabel.textAlignment = .center
        stealsLabel.font = font
        stealsLabel.textColor = .darkGray
        
        self.view.addSubview(stealsLabel)
        
        stealsLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stealsLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            stealsLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stealsLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            stealsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Steals
        let stealsTF = UITextField()
        stealsTF.text = self.liveData?.steals
        stealsTF.placeholder = "input Steals"
        stealsTF.textAlignment = .center
        stealsTF.font = fontTF
        stealsTF.textColor = .systemRed
        stealsTF.adjustsFontSizeToFitWidth = true
        stealsTF.minimumFontSize = 17
        stealsTF.keyboardType = .asciiCapableNumberPad
        stealsTF.delegate = self
        
        self.stealsTF = stealsTF
        self.view.addSubview(stealsTF)
        
        stealsTF.isUserInteractionEnabled = false
        
        stealsTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stealsTF.topAnchor.constraint(equalTo: stealsLabel.bottomAnchor, constant: 12),
            stealsTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stealsTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            stealsTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepper = UIStepper(frame: aRect)
        stepper.minimumValue = 0
        stepper.maximumValue = 300
        stepper.stepValue = 1
        
        
        stepper.value = Double((self.liveData?.steals_count)!)
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        
        self.view.addSubview(stepper)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: stealsTF.bottomAnchor, constant: 12),
            stepper.centerXAnchor.constraint(equalTo: stealsTF.centerXAnchor, constant: 30),
            stepper.widthAnchor.constraint(equalToConstant: 150),
            stepper.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let value = sender.value
        
        self.stealsTF.text = String(Int(value))
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
        guard let tmp = self.stealsTF.text, let tmp_steals = Int(tmp) else {
            return
        }
        
        self.liveData?.steals_count = tmp_steals

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let count = self.liveData?.steals_count, count < 0 {
            return false
        }
        
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
    
    var liveData: LiveData?
    var indexPath: IndexPath?
    weak var delegate: SetStealsDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetSteals(liveData!, indexPath!)
        }
    }

}


protocol SetStealsDelegate: AnyObject {
    func doSetSteals(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetStealsDelegate {
    func doSetSteals(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].steals_count = liveData.steals_count
            
            // modify show
            self.tableView.reloadData()
        }
    }
}
