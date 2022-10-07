//
//  MainViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/7.
//

import UIKit

/// main interface
///
/// content: 2 areas
/// - top area
/// - tableview
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override var prefersStatusBarHidden: Bool {return true}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.overrideUserInterfaceStyle = .light
        
        // 加载数据
        self.loadData()

        // top area
        self.createTopArea()
        
        // tableview
        self.createTableView()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: self.headerID)
        self.tableView.separatorColor = UIColor.white
        self.tableView.separatorStyle = .singleLine
        // table header gap
        self.tableView.sectionHeaderTopPadding = 0
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

    }

    var topContentView: UIView!
    
    /// Top area
    ///
    /// contain 3 areas : left, center, right
    /// - voice: Voice Button, voice to text
    /// - time: start, stop, Game Clock
    /// - players
    func createTopArea() {
        self.createTopContentView()
        self.createTopLeft()
        self.createTopCenter()
        self.createTopRight()
    }
    

    
    // Voice control listening button
    var micImageView: UIImageView!
    var voiceListeningStart = false // whether to start voice control listening
    
    var voiceToTextLabel: UILabel! // voice to text
    
    // Game Clock
    var gameClockLabel: UILabel!
    var startButton: UIButton!
    var stopButton: UIButton!

    // players
    var playersButton: UIButton!
    
    // tableView
    var tableView: UITableView!
    let cellID = "cellID"
    let headerID = "headerID"

    var allLiveDatas = [LiveData]()
    /// 加载数据
    ///
    /// 策略
    /// 1. 临时加载：数据类中人工生成
    /// 2. 数据库
    func loadData() {
        self.allLiveDatas = LiveData.createData()
        
        /*
        self.allFeedBacks = [FeedBack]()

        if let feedbacks = DAOOfMelfNote.searchAllMelfFeedBacks(id_subject: (self.subject?.id_subject)!) {
            self.allFeedBacks = feedbacks
        }
        */
    }

    /// tableview
    func createTableView() {
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        self.tableView = UITableView(frame: aRect)
        self.tableView.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        // 1.1 heightAnchor可以再优化
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topContentView.bottomAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8),
            self.tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            self.tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
        ])
        
        // 去掉行线
//        self.tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 行高动态变化
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allLiveDatas.count
    }
    
    let leading = CGFloat(20) // 37
    let trailing = CGFloat(-20) // -40
    let gap_width = CGFloat(1.5)

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        var inset = UIEdgeInsets.zero
//        inset.left = 16
//        inset.right = 16
        cell.separatorInset = inset


        cell.accessoryType = .none
        
        let font = UIFont.systemFont(ofSize: 10)
        if cell.viewWithTag(101) == nil {
            let width = (self.view.bounds.width - 16) / CGFloat(headerWords.count) // 间距1

            var aRect = CGRect(x: 8, y: 2.5, width: width, height: 30)

            do {
                let lab = UILabel(frame: aRect)
                lab.tag = 100
                lab.font = font
                lab.text = "PLAYER"
                lab.textColor = .black
                lab.textAlignment = .left
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 101
                lab.font = font
                lab.text = "NUMBER"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 102
                lab.font = font
                lab.text = "minutes"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 103
                lab.font = font
                lab.text = "per"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 104
                lab.font = font
                lab.text = "points"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 105
                lab.font = font
                lab.text = "ft"
                lab.textColor = .black
                lab.textAlignment = .center
                lab.numberOfLines = 2
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 106
                lab.font = font
                lab.text = "fg2"
                lab.textColor = .black
                lab.textAlignment = .center
                lab.numberOfLines = 2
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 107
                lab.font = font
                lab.text = "fg3"
                lab.textColor = .black
                lab.textAlignment = .center
                lab.numberOfLines = 2
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 108
                lab.font = font
                lab.text = "eFG"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 109
                lab.font = font
                lab.text = "assts"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 110
                lab.font = font
                lab.text = "orebs"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 111
                lab.font = font
                lab.text = "drebs"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 112
                lab.font = font
                lab.text = "steals"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 113
                lab.font = font
                lab.text = "blocks"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 114
                lab.font = font
                lab.text = "defs"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 115
                lab.font = font
                lab.text = "charges"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = gap_width
                bRect.size.height = 40
                bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 116
                lab.font = font
                lab.text = "tos"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
            }
        }
        
        let liveData = self.allLiveDatas[indexPath.row]
        
        do {
            let lab = cell.contentView.viewWithTag(100) as! UILabel
            lab.text = String(liveData.player!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(101) as! UILabel
            lab.text = String(liveData.number!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(102) as! UILabel
            lab.text = String(liveData.minutes!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(103) as! UILabel
            lab.text = String(liveData.per!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(104) as! UILabel
            lab.text = String(liveData.points!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(105) as! UILabel
            lab.text = String(liveData.ft)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(106) as! UILabel
            lab.text = String(liveData.fg2)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(107) as! UILabel
            lab.text = String(liveData.fg3)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(108) as! UILabel
            lab.text = String(liveData.eFG!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(109) as! UILabel
            lab.text = String(liveData.assts!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(110) as! UILabel
            lab.text = String(liveData.orebs!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(111) as! UILabel
            lab.text = String(liveData.drebs!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(112) as! UILabel
            lab.text = String(liveData.steals!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(113) as! UILabel
            lab.text = String(liveData.blocks!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(114) as! UILabel
            lab.text = String(liveData.defs!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(115) as! UILabel
            lab.text = String(liveData.charges!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(116) as! UILabel
            lab.text = String(liveData.tos!)
        }
        

        
        //背景颜色：相邻的两行颜色不同（奇偶不同）
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .systemGray3
            cell.contentView.backgroundColor = .systemGray3
        }
        else {
            cell.backgroundColor = .systemGray5
            cell.contentView.backgroundColor = .systemGray5
        }

        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    let headerWords = ["PLAYER", "NUMBER", "MINUTES", "PER", "POINTS", "FT", "2FG", "3FG", "eFG%", "ASSTS", "OREBS", "DREBS", "STEALS", "BLOCKS", "DEFS", "CHARGES", "TOS"]
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView( withIdentifier: self.headerID)!
        // section：背景色
        headerView.backgroundView = UIView()
        headerView.backgroundView?.backgroundColor = .white
        
        let font = UIFont.systemFont(ofSize: 10)

        if headerView.viewWithTag(1000) == nil {
            let width = (self.view.bounds.width - 16) / CGFloat(headerWords.count) // 间距1

            var aRect = CGRect(x: 8, y: 5, width: width, height: 30)

            for (index, str) in headerWords.enumerated() {
                if index == 0 {
                    
                } else {
                    aRect.origin.x += width
                }
                
                
                let lab = UILabel(frame: aRect)
                lab.tag = 1000 + index
                lab.font = font
                lab.text = str
                lab.textColor = .white
                lab.textAlignment = .center
                headerView.contentView.addSubview(lab)
                
                if index != headerWords.count - 1 {
                    // 最后一个，没有分割线
                    var bRect = aRect
                    bRect.size.width = gap_width
                    bRect.size.height = 40
                    bRect.origin.x = aRect.origin.x + aRect.width - gap_width
                    bRect.origin.y = 0
                    let view = UIView(frame: bRect)
                    view.backgroundColor = UIColor.white
                    
                    headerView.contentView.addSubview(view)
                }
                
            }
        }
        
        headerView.contentView.backgroundColor = UIColor.blue
        
        return headerView
    }
}

