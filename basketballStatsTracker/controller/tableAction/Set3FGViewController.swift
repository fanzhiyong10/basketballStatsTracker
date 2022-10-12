//
//  Set3FGViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class Set3FGViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set 3FG"

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
    
    var fg3MakeTF: UITextField!
    var fg3MissTF: UITextField!

    /// FG3
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: 3FG Make
        let fg3MakeLabel = UILabel()
        fg3MakeLabel.text = "3FG Make"
        fg3MakeLabel.textAlignment = .center
        fg3MakeLabel.font = font
        fg3MakeLabel.textColor = .darkGray
        
        self.view.addSubview(fg3MakeLabel)
        
        fg3MakeLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            fg3MakeLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            fg3MakeLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            fg3MakeLabel.widthAnchor.constraint(equalToConstant: 200),
            fg3MakeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // label: 3FG Miss
        let fg3MissLabel = UILabel()
        fg3MissLabel.text = "3FG Miss"
        fg3MissLabel.textAlignment = .center
        fg3MissLabel.font = font
        fg3MissLabel.textColor = .darkGray
        
        self.view.addSubview(fg3MissLabel)
        
        fg3MissLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fg3MissLabel.centerYAnchor.constraint(equalTo: fg3MakeLabel.centerYAnchor),
            fg3MissLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            fg3MissLabel.widthAnchor.constraint(equalTo: fg3MakeLabel.widthAnchor),
            fg3MissLabel.heightAnchor.constraint(equalTo: fg3MakeLabel.heightAnchor)
        ])
        
        // 3FG Make
        let fg3MakeTF = UITextField()
        fg3MakeTF.text = String((self.liveData?.fg3_make_count)!)
        fg3MakeTF.placeholder = "input 3FG Make"
        fg3MakeTF.textAlignment = .center
        fg3MakeTF.font = fontTF
        fg3MakeTF.textColor = .systemRed
        fg3MakeTF.adjustsFontSizeToFitWidth = true
        fg3MakeTF.minimumFontSize = 17
        fg3MakeTF.keyboardType = .asciiCapableNumberPad
        fg3MakeTF.delegate = self
        
        self.fg3MakeTF = fg3MakeTF
        self.view.addSubview(fg3MakeTF)
        
        fg3MakeTF.isUserInteractionEnabled = false
        
        fg3MakeTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fg3MakeTF.topAnchor.constraint(equalTo: fg3MakeLabel.bottomAnchor, constant: 12),
            fg3MakeTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            fg3MakeTF.widthAnchor.constraint(equalTo: fg3MakeLabel.widthAnchor),
            fg3MakeTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // 3FG Miss
        let fg3MissTF = UITextField()
        fg3MissTF.text = String((self.liveData?.fg3_miss_count)!)
        fg3MissTF.placeholder = "input 3FG Miss"
        fg3MissTF.textAlignment = .center
        fg3MissTF.font = fontTF
        fg3MissTF.textColor = .systemRed
        fg3MissTF.adjustsFontSizeToFitWidth = true
        fg3MissTF.minimumFontSize = 17
        fg3MissTF.keyboardType = .asciiCapableNumberPad
        fg3MissTF.delegate = self
        
        self.fg3MissTF = fg3MissTF
        self.view.addSubview(fg3MissTF)
        
        fg3MissTF.isUserInteractionEnabled = false
        
        fg3MissTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fg3MissTF.centerYAnchor.constraint(equalTo: fg3MakeTF.centerYAnchor),
            fg3MissTF.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            fg3MissTF.widthAnchor.constraint(equalTo: fg3MakeTF.widthAnchor),
            fg3MissTF.heightAnchor.constraint(equalTo: fg3MakeTF.heightAnchor)
        ])
        
        // stepper Make
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepperMake = UIStepper(frame: aRect)
        stepperMake.minimumValue = 0
        stepperMake.maximumValue = 300
        stepperMake.stepValue = 1
        
        
        stepperMake.value = Double((self.liveData?.fg3_make_count)!)
        stepperMake.addTarget(self, action: #selector(stepperChangedMake), for: .valueChanged)
        
        self.view.addSubview(stepperMake)
        
        stepperMake.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperMake.topAnchor.constraint(equalTo: fg3MakeTF.bottomAnchor, constant: 12),
            stepperMake.centerXAnchor.constraint(equalTo: fg3MakeTF.centerXAnchor, constant: 30),
            stepperMake.widthAnchor.constraint(equalToConstant: 150),
            stepperMake.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper Miss
//        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepperMiss = UIStepper(frame: aRect)
        stepperMiss.minimumValue = 0
        stepperMiss.maximumValue = 300
        stepperMiss.stepValue = 1
        
        
        stepperMiss.value = Double((self.liveData?.fg3_miss_count)!)
        stepperMiss.addTarget(self, action: #selector(stepperChangedMiss), for: .valueChanged)
        
        self.view.addSubview(stepperMiss)
        
        stepperMiss.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperMiss.topAnchor.constraint(equalTo: fg3MissTF.bottomAnchor, constant: 12),
            stepperMiss.centerXAnchor.constraint(equalTo: fg3MissTF.centerXAnchor, constant: 30),
            stepperMiss.widthAnchor.constraint(equalTo: stepperMake.widthAnchor),
            stepperMiss.heightAnchor.constraint(equalTo: stepperMake.heightAnchor)
        ])
    }
    
    @objc func stepperChangedMake(_ sender: UIStepper) {
        let value = sender.value
        
        self.fg3MakeTF.text = String(Int(value))
    }
    
    @objc func stepperChangedMiss(_ sender: UIStepper) {
        let value = sender.value
        
        self.fg3MissTF.text = String(Int(value))
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
        guard let tmp = self.fg3MakeTF.text, let tmp_make = Int(tmp) else {
            return
        }
        
        guard let tmp2 = self.fg3MissTF.text, let tmp_miss = Int(tmp2) else {
            return
        }
        
        self.liveData?.fg3_make_count = tmp_make
        self.liveData?.fg3_miss_count = tmp_miss

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let count = self.liveData?.fg3_make_count, count < 0 {
            return false
        }
        
        if let count = self.liveData?.fg3_miss_count, count < 0 {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "3FG cannot be less than 0"
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
    weak var delegate: Set3FGDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSet3FG(liveData!, indexPath!)
        }
    }

}


protocol Set3FGDelegate: AnyObject {
    func doSet3FG(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: Set3FGDelegate {
    func doSet3FG(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].fg3_make_count = liveData.fg3_make_count
            self.allLiveDatas[indexPath.row].fg3_miss_count = liveData.fg3_miss_count

            // modify show
            self.tableView.reloadData()
        }
    }
}
