//
//  VoiceTextTableViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/9.
//

import UIKit

class VoiceTextTableViewController: UITableViewController {
    var allLiveDatas = [LiveData]()

    
    let cellID = "Cell"
    let headerID = "HeaderOfSection"

    var sections = [String]()
    var sectionVoiceCommands = [String]()
    var sectionNumbers = [String]()
    var sectionPlayers = [String]()

    /// table data
    ///
    /// include:
    /// - sections
    /// - detail in section
    func createData() {
        var str = "VOICE COMMANDS"
        sections.append(str)
        
        str = "Numbers"
        sections.append(str)
        
        str = "Players"
        sections.append(str)
        
        self.createSectionData()
    }
    
    /// section data
    ///
    /// include 3 catalog:
    /// - VOICE COMMANDS
    /// - Numbers
    /// - Players
    func createSectionData() {
        self.createDataOfVoiceCommands()
        self.createDataOfNumbers()
        self.createDataOfPlayers()
    }
    
    /// VOICE COMMANDS
    func createDataOfVoiceCommands() {
        sectionVoiceCommands = ["MAKE", "MISS", "BUCKET", "BRICK", "SWISH", "OFF", "BOARD", "GLASS", "DIME", "BAD", "STEAL", "BLOCK", "TIP", "CHARGE"]
    }
    
    /// Numbers
    func createDataOfNumbers() {
        let sortDatas = allLiveDatas.sorted { (s1, s2) -> Bool in
            let tmp = Int(s1.number!)! < Int(s2.number!)!
            
            return tmp
        }
        
        for liveData in sortDatas {
            sectionNumbers.append(liveData.number!)
        }
    }
    
    /// Players
    func createDataOfPlayers() {
        let sortDatas = allLiveDatas.sorted { (s1, s2) -> Bool in
            let tmp = s1.player! < s2.player!
            
            return tmp
        }
        
        for liveData in sortDatas {
            sectionPlayers.append(liveData.player!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        self.createNavigatorBar()

        self.createData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Voice Text List and Training"
        
        // 注册TableViewCell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        
        // 注册UITableViewHeaderFooterView
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: self.headerID)
        
        self.enableDictation()
        
        self.tableView.backgroundColor = .systemGray6
    }
    
    func createNavigatorBar() {
        let image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        
        let close_item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeWindow))
        self.navigationItem.leftBarButtonItem = close_item
    }
    
    @objc func closeWindow() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    /// enable dictation
    func enableDictation() {
        let height: CGFloat = 70
        let numberOfLines = 3
        
        let width = self.tableView.bounds.width
        let aRect = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: aRect)
        
//        let s0 = " 必须启用听写，方可使用声控：设置->通用->键盘->启用听写\n 注：为了更好地适应自己的声音，需要训练一下"
        label.text = " Dictation must be enabled to use voice control:\n\t Settings -> General -> Keyboard -> Enable Dictation. \n Note: Training can improve the accuracy of voice control"
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .natural
        label.textColor = .black
        label.numberOfLines = numberOfLines
        self.tableView.tableHeaderView = label
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            // Voice Commands
            return self.sectionVoiceCommands.count
            
        case 1:
            // numbers
            return self.sectionNumbers.count
            
        case 2:
            // Players
            return self.sectionPlayers.count
            
        default:
            return self.sectionVoiceCommands.count
        }
    }


    class ButtonInTable: UIButton {
        var indexPath: IndexPath?
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        cell.separatorInset = UIEdgeInsets.zero
        
        if cell.viewWithTag(200) == nil {
            let font = UIFont.systemFont(ofSize: 20)
            let width: CGFloat = 200

            var aRect = CGRect(x: 20, y: 10, width: width, height: 30) //110
            let gap: CGFloat = 60
            
            let lab = UILabel(frame: aRect)
            lab.tag = 200
            lab.font = font
            lab.textColor = .black
            lab.backgroundColor = .clear
            lab.text = "Word"
            lab.textAlignment = .left
            cell.contentView.addSubview(lab)
            
            aRect.size.width = 100 // 90
            aRect.size.height = 36
            aRect.origin.y = 7
            aRect.origin.x += lab.bounds.width + gap
            let button = ButtonInTable(frame: aRect)
            button.tag = 201
            let str_as = NSMutableAttributedString(string:"Training", attributes: [ .font:font, .foregroundColor: UIColor.red])
            button.setAttributedTitle(str_as, for: .normal)
            button.backgroundColor = UIColor.red.withAlphaComponent(0.1)
            button.layer.cornerRadius = 5
            cell.contentView.addSubview(button)
            
            do {
                aRect.size.width = 130 // 90
                aRect.size.height = 36
                aRect.origin.y = 7
                aRect.origin.x += button.bounds.width + gap
                let button = ButtonInTable(frame: aRect)
                button.tag = 202
                let str_as = NSMutableAttributedString(string:"Vocabulary", attributes: [ .font:font, .foregroundColor: UIColor.systemBlue])
                button.setAttributedTitle(str_as, for: .normal)
                button.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.1)
                button.layer.cornerRadius = 5
                cell.contentView.addSubview(button)
            }
            
        }
        
        do {
            let button = cell.contentView.viewWithTag(201) as! ButtonInTable
            button.indexPath = indexPath
            button.addTarget(self, action: #selector(toTrain), for: .touchUpInside)
        }
        
        do {
            let button = cell.contentView.viewWithTag(202) as! ButtonInTable
            button.indexPath = indexPath
            button.addTarget(self, action: #selector(toVocabulary), for: .touchUpInside)
        }

        let lab = cell.contentView.viewWithTag(200) as! UILabel
        
        switch indexPath.section {
        case 0:
            lab.text = self.sectionVoiceCommands[indexPath.row]

        case 1:
            lab.text = self.sectionNumbers[indexPath.row]

        case 2:
            lab.text = self.sectionPlayers[indexPath.row]

        default:
            break
        }
        
        //背景颜色：相邻的两行颜色不同（奇偶不同）
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = .systemGray3
        }
        else {
            cell.contentView.backgroundColor = .systemGray5
        }
        
        cell.selectionStyle = .none;

        return cell
    }
    
    var trainSpeechOfViewController: VoiceTrainingViewController?
    @objc func toTrain(_ sender: ButtonInTable) {
        // 可以传递控制参量
        print("toTrain")
        guard let indexPath = sender.indexPath else { return }
        
        print("indexPath: \(indexPath)")
        var speechComandWords = "speechComandWords"
        var text = ""
        
        var title = "Voice Training "
        
        switch indexPath.section {
        case 0:
            text = self.sectionVoiceCommands[indexPath.row]
            title += " Command: \(text)"

        case 1:
            text = self.sectionNumbers[indexPath.row]
            title += " Number: \(text)"

        case 2:
            text = self.sectionPlayers[indexPath.row]
            title += " Player: \(text)"

        default:
            break
        }
        
        speechComandWords += "_\(indexPath.section)_\(indexPath.row)"
        
        self.trainSpeechOfViewController = VoiceTrainingViewController()
        self.trainSpeechOfViewController?.speechComandWords = speechComandWords // 需要紧挨着初始化，否则会有问题
        self.trainSpeechOfViewController?.indexPath = indexPath
        self.trainSpeechOfViewController?.number = text.count
        self.trainSpeechOfViewController?.view.frame = CGRect(x: 0,y: 0,width: 650, height: 650)
        self.trainSpeechOfViewController?.preferredContentSize = CGSize(width: 650, height: 650)

        let nav = UINavigationController(rootViewController: self.trainSpeechOfViewController!)
        
        
        var image = UIImage(named: "xmark.circle")
        if #available(iOS 14.0, *) {
            image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        }
        let cancel = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(cancelPop1))
        self.trainSpeechOfViewController?.navigationItem.leftBarButtonItem = cancel

        self.trainSpeechOfViewController?.navigationItem.title = title

        
        nav.modalPresentationStyle = .popover // 弹窗模式
        nav.isModalInPopover = true // modal，点击窗口的外面，不会关闭窗口
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = self.view
            pop.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            pop.permittedArrowDirections = UIPopoverArrowDirection() // 去掉箭头
        }
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBlue
            appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
            nav.navigationBar.barTintColor = .systemBlue // works in iOS 8
            nav.navigationBar.tintColor = .white
        }

    }
    
    @objc func cancelPop1(_ sender: Any) {
        // 停止语音识别
        self.trainSpeechOfViewController?.trainSpeechRecognize?.stop()
        
        // close
        self.dismiss(animated:true)
    }
    
    //toVocabulary
    @objc func toVocabulary(_ sender: ButtonInTable) {
        // 可以传递控制参量
        print("toVocabulary")
        guard let indexPath = sender.indexPath else { return }
        
        print("indexPath: \(indexPath)")
        var speechComandWords = "speechComandWords"
        var text = ""
        
        var title = "Vocabulary "
        
        switch indexPath.section {
        case 0:
            text = self.sectionVoiceCommands[indexPath.row]
            title += " Command: \(text)"

        case 1:
            text = self.sectionNumbers[indexPath.row]
            title += " Number: \(text)"

        case 2:
            text = self.sectionPlayers[indexPath.row]
            title += " Player: \(text)"

        default:
            break
        }
        
        speechComandWords += "_\(indexPath.section)_\(indexPath.row)"
        
        let vc = MakeVocabularyViewController()
        vc.speechComandWords = speechComandWords
        vc.indexPath = indexPath
        vc.view.frame = CGRect(x: 0,y: 0,width: 650, height: 650)
        vc.preferredContentSize = CGSize(width: 650, height: 250)

        let nav = UINavigationController(rootViewController: vc)
        
        
        vc.navigationItem.title = title

        
        nav.modalPresentationStyle = .popover // 弹窗模式
        nav.isModalInPopover = true // modal，点击窗口的外面，不会关闭窗口
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = self.view
            pop.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            pop.permittedArrowDirections = UIPopoverArrowDirection() // 去掉箭头
        }
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBlue
            appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
            nav.navigationBar.barTintColor = .systemBlue // works in iOS 8
            nav.navigationBar.tintColor = .white
        }

    }
    
    //节：section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = (tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID))!
        
        // section：背景色
        headerView.backgroundView = UIView()
        headerView.backgroundView?.backgroundColor = .systemTeal

        let bigfont = UIFont.systemFont(ofSize: 28)
        let fontColor = UIColor.black
        
        let str = self.sections[section]
        
        if headerView.viewWithTag(1000) == nil {
            let aRect = CGRect(x: 10, y: 11, width: 600, height: 28)
            let label = UILabel(frame: aRect)
            label.tag = 1000
            label.backgroundColor = .clear
            label.attributedText = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: fontColor])
            label.textAlignment = .left
            headerView.contentView.addSubview(label)
        }
        
        let label = headerView.contentView.viewWithTag(1000) as! UILabel
        label.attributedText = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font: bigfont, NSAttributedString.Key.foregroundColor: fontColor])
        
        return headerView
    }
    
    // this seems to be unnecessary!
    // that's because it's configured in the nib
    // but if we do implement it, we have to behave sensibly
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
