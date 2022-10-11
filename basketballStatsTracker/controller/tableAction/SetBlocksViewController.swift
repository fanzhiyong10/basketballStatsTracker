//
//  SetBlocksViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

class SetBlocksViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .systemGray6
        
        self.title = "Set Blocks"

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
    
    var blocksTF: UITextField!
    
    /// Blocks
    func createInterface() {
        let font = UIFont.systemFont(ofSize: 24)
        let fontTF = UIFont.systemFont(ofSize: 48, weight: .bold)
        // label: Blocks
        let blocksLabel = UILabel()
        blocksLabel.text = "Blocks"
        blocksLabel.textAlignment = .center
        blocksLabel.font = font
        blocksLabel.textColor = .darkGray
        
        self.view.addSubview(blocksLabel)
        
        blocksLabel.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            blocksLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            blocksLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            blocksLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            blocksLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // blocks
        let blocksTF = UITextField()
        blocksTF.text = self.liveData?.blocks
        blocksTF.placeholder = "input blocks"
        blocksTF.textAlignment = .center
        blocksTF.font = fontTF
        blocksTF.textColor = .systemRed
        blocksTF.adjustsFontSizeToFitWidth = true
        blocksTF.minimumFontSize = 17
        blocksTF.keyboardType = .asciiCapableNumberPad
        blocksTF.delegate = self
        
        self.blocksTF = blocksTF
        self.view.addSubview(blocksTF)
        
        blocksTF.isUserInteractionEnabled = false
        
        blocksTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blocksTF.topAnchor.constraint(equalTo: blocksLabel.bottomAnchor, constant: 12),
            blocksTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            blocksTF.widthAnchor.constraint(equalTo: safe.widthAnchor),
            blocksTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // stepper
        let aRect = CGRect(x: 650, y: 125, width: 150, height: 60)
        let stepper = UIStepper(frame: aRect)
        stepper.minimumValue = 0
        stepper.maximumValue = 300
        stepper.stepValue = 1
        
        
        stepper.value = Double((self.liveData?.blocks_count)!)
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        
        self.view.addSubview(stepper)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: blocksTF.bottomAnchor, constant: 12),
            stepper.centerXAnchor.constraint(equalTo: blocksTF.centerXAnchor, constant: 30),
            stepper.widthAnchor.constraint(equalToConstant: 150),
            stepper.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let value = sender.value
        
        self.blocksTF.text = String(Int(value))
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
        guard let tmp = self.blocksTF.text, let tmp_blocks = Int(tmp) else {
            return
        }
        
        self.liveData?.blocks_count = tmp_blocks

        guard self.validSelect() else {
            // alert error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }

    func validSelect() -> Bool {
        if let count = self.liveData?.blocks_count, count < 0 {
            return false
        }
        
        return true
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Blocks cannot be less than 0"
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
    weak var delegate: SetBlocksDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetBlocks(liveData!, indexPath!)
        }
    }

}


protocol SetBlocksDelegate: AnyObject {
    func doSetBlocks(_ liveData: LiveData, _ indexPath: IndexPath)
}

extension MainViewController: SetBlocksDelegate {
    func doSetBlocks(_ liveData: LiveData, _ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.allLiveDatas[indexPath.row].blocks_count = liveData.blocks_count
            
            // modify show
            self.tableView.reloadData()
        }
    }
}
