//
//  SetFTViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetFTViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set FT"

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
    
    var ftMakeTF: UITextField!
    var ftMissTF: UITextField!

    /// FT
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: FT Make
        let ftMakeLabel = UILabel()
        ftMakeLabel.text = "FT Make"
        ftMakeLabel.textAlignment = .center
        ftMakeLabel.font = font
        ftMakeLabel.textColor = .darkGray
        
        self.view.addSubview(ftMakeLabel)
        
        ftMakeLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            ftMakeLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            ftMakeLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            ftMakeLabel.widthAnchor.constraint(equalToConstant: 200),
            ftMakeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // label: FT Miss
        let ftMissLabel = UILabel()
        ftMissLabel.text = "FT Miss"
        ftMissLabel.textAlignment = .center
        ftMissLabel.font = font
        ftMissLabel.textColor = .darkGray
        
        self.view.addSubview(ftMissLabel)
        
        ftMissLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ftMissLabel.centerYAnchor.constraint(equalTo: ftMakeLabel.centerYAnchor),
            ftMissLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            ftMissLabel.widthAnchor.constraint(equalTo: ftMakeLabel.widthAnchor),
            ftMissLabel.heightAnchor.constraint(equalTo: ftMakeLabel.heightAnchor)
        ])
        
        // FT Make
        let ftMakeTF = UITextField()
        ftMakeTF.text = String((self.liveData?.ft_make_count)!)
        ftMakeTF.placeholder = "input FT Make"
        ftMakeTF.textAlignment = .center
        ftMakeTF.font = fontTF
        ftMakeTF.textColor = .systemRed
        ftMakeTF.adjustsFontSizeToFitWidth = true
        ftMakeTF.minimumFontSize = 17
        ftMakeTF.keyboardType = .asciiCapableNumberPad
        ftMakeTF.delegate = self
        
        self.ftMakeTF = ftMakeTF
        self.view.addSubview(ftMakeTF)
        
        ftMakeTF.isUserInteractionEnabled = false
        
        ftMakeTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ftMakeTF.topAnchor.constraint(equalTo: ftMakeLabel.bottomAnchor, constant: 12),
            ftMakeTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            ftMakeTF.widthAnchor.constraint(equalTo: ftMakeLabel.widthAnchor),
            ftMakeTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // FT Miss
        let ftMissTF = UITextField()
        ftMissTF.text = String((self.liveData?.ft_miss_count)!)
        ftMissTF.placeholder = "input FT Miss"
        ftMissTF.textAlignment = .center
        ftMissTF.font = fontTF
        ftMissTF.textColor = .systemRed
        ftMissTF.adjustsFontSizeToFitWidth = true
        ftMissTF.minimumFontSize = 17
        ftMissTF.keyboardType = .asciiCapableNumberPad
        ftMissTF.delegate = self
        
        self.ftMissTF = ftMissTF
        self.view.addSubview(ftMissTF)
        
        ftMissTF.isUserInteractionEnabled = false
        
        ftMissTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ftMissTF.centerYAnchor.constraint(equalTo: ftMakeTF.centerYAnchor),
            ftMissTF.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            ftMissTF.widthAnchor.constraint(equalTo: ftMakeTF.widthAnchor),
            ftMissTF.heightAnchor.constraint(equalTo: ftMakeTF.heightAnchor)
        ])
        
        // stepper Make
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepperMake = UIStepper(frame: aRect)
        stepperMake.minimumValue = 0
        stepperMake.maximumValue = 300
        stepperMake.stepValue = 1
        
        
        stepperMake.value = Double((self.liveData?.ft_make_count)!)
        stepperMake.addTarget(self, action: #selector(stepperChangedMake), for: .valueChanged)
        
        self.view.addSubview(stepperMake)
        
        stepperMake.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperMake.topAnchor.constraint(equalTo: ftMakeTF.bottomAnchor, constant: 12),
            stepperMake.centerXAnchor.constraint(equalTo: ftMakeTF.centerXAnchor, constant: 30),
            stepperMake.widthAnchor.constraint(equalToConstant: 150),
            stepperMake.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper Miss
//        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepperMiss = UIStepper(frame: aRect)
        stepperMiss.minimumValue = 0
        stepperMiss.maximumValue = 300
        stepperMiss.stepValue = 1
        
        
        stepperMiss.value = Double((self.liveData?.ft_miss_count)!)
        stepperMiss.addTarget(self, action: #selector(stepperChangedMiss), for: .valueChanged)
        
        self.view.addSubview(stepperMiss)
        
        stepperMiss.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperMiss.topAnchor.constraint(equalTo: ftMissTF.bottomAnchor, constant: 12),
            stepperMiss.centerXAnchor.constraint(equalTo: ftMissTF.centerXAnchor, constant: 30),
            stepperMiss.widthAnchor.constraint(equalTo: stepperMake.widthAnchor),
            stepperMiss.heightAnchor.constraint(equalTo: stepperMake.heightAnchor)
        ])
    }
    
    @objc func stepperChangedMake(_ sender: UIStepper) {
        let value = sender.value
        
        self.ftMakeTF.text = String(Int(value))
    }
    
    @objc func stepperChangedMiss(_ sender: UIStepper) {
        let value = sender.value
        
        self.ftMissTF.text = String(Int(value))
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
        guard let tmp = self.ftMakeTF.text, let tmp_make = Int(tmp) else {
            return
        }
        
        guard let tmp2 = self.ftMissTF.text, let tmp_miss = Int(tmp2) else {
            return
        }
        
        self.liveData?.ft_make_count = tmp_make
        self.liveData?.ft_miss_count = tmp_miss

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let count = self.liveData?.ft_make_count, count < 0 {
            return false
        }
        
        if let count = self.liveData?.ft_miss_count, count < 0 {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "FT cannot be less than 0"
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
    weak var delegate: SetFTDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetFT(liveData!, indexPath!)
        }
    }

}


protocol SetFTDelegate: AnyObject {
    func doSetFT(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetFTDelegate {
    func doSetFT(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].ft_make_count = liveData.ft_make_count
            self.allLiveDatas[indexPath.row].ft_miss_count = liveData.ft_miss_count

            // modify show
            self.tableView.reloadData()
        }
    }
}
