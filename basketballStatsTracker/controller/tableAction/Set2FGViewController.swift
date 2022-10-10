//
//  Set2FGViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class Set2FGViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set 2FG"

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
    
    var fg2MakeTF: UITextField!
    var fg2MissTF: UITextField!

    /// FG2
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: 2FG Make
        let fg2MakeLabel = UILabel()
        fg2MakeLabel.text = "2FG Make"
        fg2MakeLabel.textAlignment = .center
        fg2MakeLabel.font = font
        fg2MakeLabel.textColor = .darkGray
        
        self.view.addSubview(fg2MakeLabel)
        
        fg2MakeLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            fg2MakeLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            fg2MakeLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            fg2MakeLabel.widthAnchor.constraint(equalToConstant: 200),
            fg2MakeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // label: 2FG Miss
        let fg2MissLabel = UILabel()
        fg2MissLabel.text = "2FG Miss"
        fg2MissLabel.textAlignment = .center
        fg2MissLabel.font = font
        fg2MissLabel.textColor = .darkGray
        
        self.view.addSubview(fg2MissLabel)
        
        fg2MissLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fg2MissLabel.centerYAnchor.constraint(equalTo: fg2MakeLabel.centerYAnchor),
            fg2MissLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            fg2MissLabel.widthAnchor.constraint(equalTo: fg2MakeLabel.widthAnchor),
            fg2MissLabel.heightAnchor.constraint(equalTo: fg2MakeLabel.heightAnchor)
        ])
        
        // 2FG Make
        let fg2MakeTF = UITextField()
        fg2MakeTF.text = String((self.liveData?.fg2_make_count)!)
        fg2MakeTF.placeholder = "input 2FG Make"
        fg2MakeTF.textAlignment = .center
        fg2MakeTF.font = fontTF
        fg2MakeTF.textColor = .systemRed
        fg2MakeTF.adjustsFontSizeToFitWidth = true
        fg2MakeTF.minimumFontSize = 17
        fg2MakeTF.keyboardType = .asciiCapableNumberPad
        fg2MakeTF.delegate = self
        
        self.fg2MakeTF = fg2MakeTF
        self.view.addSubview(fg2MakeTF)
        
        fg2MakeTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fg2MakeTF.topAnchor.constraint(equalTo: fg2MakeLabel.bottomAnchor, constant: 12),
            fg2MakeTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            fg2MakeTF.widthAnchor.constraint(equalTo: fg2MakeLabel.widthAnchor),
            fg2MakeTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // 2FG Miss
        let fg2MissTF = UITextField()
        fg2MissTF.text = String((self.liveData?.fg2_miss_count)!)
        fg2MissTF.placeholder = "input 2FG Miss"
        fg2MissTF.textAlignment = .center
        fg2MissTF.font = fontTF
        fg2MissTF.textColor = .systemRed
        fg2MissTF.adjustsFontSizeToFitWidth = true
        fg2MissTF.minimumFontSize = 17
        fg2MissTF.keyboardType = .asciiCapableNumberPad
        fg2MissTF.delegate = self
        
        self.fg2MissTF = fg2MissTF
        self.view.addSubview(fg2MissTF)
        
        fg2MissTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fg2MissTF.centerYAnchor.constraint(equalTo: fg2MakeTF.centerYAnchor),
            fg2MissTF.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            fg2MissTF.widthAnchor.constraint(equalTo: fg2MakeTF.widthAnchor),
            fg2MissTF.heightAnchor.constraint(equalTo: fg2MakeTF.heightAnchor)
        ])
        
        // stepper Make
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepperMake = UIStepper(frame: aRect)
        stepperMake.minimumValue = 0
        stepperMake.maximumValue = 300
        stepperMake.stepValue = 1
        
        
        stepperMake.value = Double((self.liveData?.fg2_make_count)!)
        stepperMake.addTarget(self, action: #selector(stepperChangedMake), for: .valueChanged)
        
        self.view.addSubview(stepperMake)
        
        stepperMake.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperMake.topAnchor.constraint(equalTo: fg2MakeTF.bottomAnchor, constant: 12),
            stepperMake.centerXAnchor.constraint(equalTo: fg2MakeTF.centerXAnchor, constant: 30),
            stepperMake.widthAnchor.constraint(equalToConstant: 150),
            stepperMake.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper Miss
//        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepperMiss = UIStepper(frame: aRect)
        stepperMiss.minimumValue = 0
        stepperMiss.maximumValue = 300
        stepperMiss.stepValue = 1
        
        
        stepperMiss.value = Double((self.liveData?.fg2_miss_count)!)
        stepperMiss.addTarget(self, action: #selector(stepperChangedMiss), for: .valueChanged)
        
        self.view.addSubview(stepperMiss)
        
        stepperMiss.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperMiss.topAnchor.constraint(equalTo: fg2MissTF.bottomAnchor, constant: 12),
            stepperMiss.centerXAnchor.constraint(equalTo: fg2MissTF.centerXAnchor, constant: 30),
            stepperMiss.widthAnchor.constraint(equalTo: stepperMake.widthAnchor),
            stepperMiss.heightAnchor.constraint(equalTo: stepperMake.heightAnchor)
        ])
    }
    
    @objc func stepperChangedMake(_ sender: UIStepper) {
        let value = sender.value
        
        self.fg2MakeTF.text = String(Int(value))
    }
    
    @objc func stepperChangedMiss(_ sender: UIStepper) {
        let value = sender.value
        
        self.fg2MissTF.text = String(Int(value))
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
        guard let tmp = self.fg2MakeTF.text, let tmp_make = Int(tmp) else {
            return
        }
        
        guard let tmp2 = self.fg2MissTF.text, let tmp_miss = Int(tmp2) else {
            return
        }
        
        self.liveData?.fg2_make_count = tmp_make
        self.liveData?.fg2_miss_count = tmp_miss

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let count = self.liveData?.fg2_make_count, count < 0 {
            return false
        }
        
        if let count = self.liveData?.fg2_miss_count, count < 0 {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "2FG cannot be less than 0"
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
    weak var delegate: Set2FGDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSet2FG(liveData!, indexPath!)
        }
    }

}


protocol Set2FGDelegate: AnyObject {
    func doSet2FG(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: Set2FGDelegate {
    func doSet2FG(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].fg2_make_count = liveData.fg2_make_count
            self.allLiveDatas[indexPath.row].fg2_miss_count = liveData.fg2_miss_count

            // modify show
            self.tableView.reloadData()
        }
    }
}
