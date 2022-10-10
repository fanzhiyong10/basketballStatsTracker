//
//  SetNumberViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetNumberViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Number"

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
    
    var numberTF: UITextField!
    
    /// Player
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: minutes, seconds
        let numberLabel = UILabel()
        numberLabel.text = "Number"
        numberLabel.textAlignment = .center
        numberLabel.font = font
        numberLabel.textColor = .darkGray
        
        self.view.addSubview(numberLabel)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            numberLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            numberLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            numberLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // The range of minutes is
        let numberTF = UITextField()
        numberTF.text = self.liveData?.number
        numberTF.placeholder = "input number"
        numberTF.textAlignment = .center
        numberTF.font = fontTF
        numberTF.textColor = .systemRed
        numberTF.adjustsFontSizeToFitWidth = true
        numberTF.minimumFontSize = 17
        numberTF.keyboardType = .asciiCapableNumberPad
        numberTF.delegate = self
        
        self.numberTF = numberTF
        self.view.addSubview(numberTF)
        
        numberTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberTF.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 12),
            numberTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            numberTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            numberTF.heightAnchor.constraint(equalToConstant: 60)
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
        guard let tmp_number = self.numberTF.text else {
            return
        }
        
        self.liveData?.number = tmp_number

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
            let title = "Number cannot be empty"
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
    weak var delegate: SetNumberDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetNumber(liveData!, indexPath!)
        }
    }

}


protocol SetNumberDelegate: AnyObject {
    func doSetNumber(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetNumberDelegate {
    func doSetNumber(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].number = liveData.number
            
            // modify show
            self.tableView.reloadData()
        }
    }
}
