//
//  SetDefsViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetDefsViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Defs"

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
    
    var defsTF: UITextField!
    
    /// Defs
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: Defs
        let defsLabel = UILabel()
        defsLabel.text = "Defs"
        defsLabel.textAlignment = .center
        defsLabel.font = font
        defsLabel.textColor = .darkGray
        
        self.view.addSubview(defsLabel)
        
        defsLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            defsLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            defsLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            defsLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            defsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // defs
        let defsTF = UITextField()
        defsTF.text = self.liveData?.defs
        defsTF.placeholder = "input defs"
        defsTF.textAlignment = .center
        defsTF.font = fontTF
        defsTF.textColor = .systemRed
        defsTF.adjustsFontSizeToFitWidth = true
        defsTF.minimumFontSize = 17
        defsTF.keyboardType = .asciiCapableNumberPad
        defsTF.delegate = self
        
        self.defsTF = defsTF
        self.view.addSubview(defsTF)
        
        defsTF.isUserInteractionEnabled = false
        
        defsTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            defsTF.topAnchor.constraint(equalTo: defsLabel.bottomAnchor, constant: 12),
            defsTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            defsTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            defsTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepper = UIStepper(frame: aRect)
        stepper.minimumValue = 0
        stepper.maximumValue = 300
        stepper.stepValue = 1
        
        
        stepper.value = Double((self.liveData?.defs_count)!)
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        
        self.view.addSubview(stepper)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: defsTF.bottomAnchor, constant: 12),
            stepper.centerXAnchor.constraint(equalTo: defsTF.centerXAnchor, constant: 30),
            stepper.widthAnchor.constraint(equalToConstant: 150),
            stepper.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let value = sender.value
        
        self.defsTF.text = String(Int(value))
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
        guard let tmp = self.defsTF.text, let tmp_defs = Int(tmp) else {
            return
        }
        
        self.liveData?.defs_count = tmp_defs

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let count = self.liveData?.defs_count, count < 0 {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Defs cannot be less than 0"
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
    weak var delegate: SetDefsDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetDefs(liveData!, indexPath!)
        }
    }

}


protocol SetDefsDelegate: AnyObject {
    func doSetDefs(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetDefsDelegate {
    func doSetDefs(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].defs_count = liveData.defs_count
            
            // modify show
            self.tableView.reloadData()
        }
    }
}
