//
//  SubstitutePlayersViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/8.
//

import UIKit

/// Substitute Players
///
/// content
/// - navigator bar button:  close button, DONE button
/// - players list
class SubstitutePlayersViewController: UITableViewController {

    // data
    var allLiveDatas: [LiveData]!
    var sortDatas: [LiveData]!
    
    let cellID = "CellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.overrideUserInterfaceStyle = .light

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.createNavigatorBar()
        
        self.processData()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
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
        
//        let done_item = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneSelected))
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
        guard self.validSelect() else {
            // alert selected error
            self.alertSelectedError()
            return
        }
        
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }
    
    var count_select = 0
    var number_onCourt: [String]? // player number on the court
    /// 5 players
    func validSelect() -> Bool {
        self.number_onCourt = [String]()
        
        self.count_select = 0
        for livedata in self.sortDatas {
            if livedata.isOnCourt {
                count_select += 1
                
                self.number_onCourt?.append(livedata.number!)
            }
        }
        
        if count_select == 5 {
            return true
        }
        
        return false
    }
    
    /// alert selected error
    func alertSelectedError() {
        DispatchQueue.main.async {
            let title = "Wrong number of players selected: \(self.count_select)"
            let message = "The number of players on the court must be 5, please re-select"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.overrideUserInterfaceStyle = .light
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func processData() {
        self.sortDatas = allLiveDatas.sorted { (s1, s2) -> Bool in
            let tmp = s1.player! < s2.player!
            
            return tmp
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allLiveDatas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)

        cell.separatorInset = UIEdgeInsets.zero
        cell.accessoryType = .none
        
        let font = UIFont.systemFont(ofSize: 20)
        let liveData = self.sortDatas[indexPath.row]
        let str = liveData.player! + " #" + liveData.number!
        
        cell.textLabel!.text = str
        cell.textLabel!.font = font
        cell.textLabel!.textColor = .black
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.accessoryType = .none
        
        if liveData.isOnCourt {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData() // deselect all cells, reassign checkmark as needed
        
        if self.sortDatas[indexPath.row].isOnCourt == true {
            self.sortDatas[indexPath.row].isOnCourt = false
        } else {
            self.sortDatas[indexPath.row].isOnCourt = true
        }
    }
    
    weak var delegate: SelectedNumbersDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.selectPlayerNumbers(self.number_onCourt!)
        }
    }

}

protocol SelectedNumbersDelegate: AnyObject {
    func selectPlayerNumbers(_ playerNumbers: [String])
}

extension MainViewController: SelectedNumbersDelegate {
    func selectPlayerNumbers(_ playerNumbers: [String]) {
        DispatchQueue.main.async {
            self.doSelectPlayerNumbers(playerNumbers)
        }
    }
}
