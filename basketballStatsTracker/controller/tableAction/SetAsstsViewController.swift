//
//  SetAsstsViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetAsstsViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Assts"

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
    
    var asstsTF: UITextField!
    
    /// assts
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: Assts
        let asstsLabel = UILabel()
        asstsLabel.text = "Assts"
        asstsLabel.textAlignment = .center
        asstsLabel.font = font
        asstsLabel.textColor = .darkGray
        
        self.view.addSubview(asstsLabel)
        
        asstsLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            asstsLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            asstsLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            asstsLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            asstsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // assts
        let asstsTF = UITextField()
        asstsTF.text = self.liveData?.assts
        asstsTF.placeholder = "input assts"
        asstsTF.textAlignment = .center
        asstsTF.font = fontTF
        asstsTF.textColor = .systemRed
        asstsTF.adjustsFontSizeToFitWidth = true
        asstsTF.minimumFontSize = 17
        asstsTF.keyboardType = .asciiCapableNumberPad
        asstsTF.delegate = self
        
        self.asstsTF = asstsTF
        self.view.addSubview(asstsTF)
        
        asstsTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            asstsTF.topAnchor.constraint(equalTo: asstsLabel.bottomAnchor, constant: 12),
            asstsTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            asstsTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            asstsTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepper = UIStepper(frame: aRect)
        stepper.minimumValue = 0
        stepper.maximumValue = 300
        stepper.stepValue = 1
        
        
        stepper.value = Double((self.liveData?.assts_count)!)
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        
        self.view.addSubview(stepper)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: asstsTF.bottomAnchor, constant: 12),
            stepper.centerXAnchor.constraint(equalTo: asstsTF.centerXAnchor, constant: 30),
            stepper.widthAnchor.constraint(equalToConstant: 150),
            stepper.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let value = sender.value
        
        self.asstsTF.text = String(Int(value))
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
        guard let tmp = self.asstsTF.text, let tmp_assts = Int(tmp) else {
            return
        }
        
        self.liveData?.assts_count = tmp_assts

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let assts_count = self.liveData?.assts_count, assts_count < 0 {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Assts cannot be less than 0"
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
    weak var delegate: SetAsstsDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetAssts(liveData!, indexPath!)
        }
    }

}


protocol SetAsstsDelegate: AnyObject {
    func doSetAssts(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetAsstsDelegate {
    func doSetAssts(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].assts_count = liveData.assts_count
            
            // modify show
            self.tableView.reloadData()
        }
    }
}
