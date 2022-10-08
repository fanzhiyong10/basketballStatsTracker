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
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: self.footerID)
        
        self.tableView.separatorColor = UIColor.white
        self.tableView.separatorStyle = .singleLine
        
        // table header gap
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        
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
    let footerID = "footerID"

    var allLiveDatas = [LiveData]()
    var totalData: LiveData?
    /// 加载数据
    ///
    /// 策略
    /// 1. 临时加载：数据类中人工生成
    /// 2. 数据库
    func loadData() {
        self.allLiveDatas = LiveData.createData()
        
        self.totalData = LiveData()
        self.totalData?.player = "TOTALS"
        self.totalData?.number = ""
        
        var time_cumulative: Float = 0
        var ft_make_count: Int = 0
        var ft_miss_count: Int = 0
        var fg2_make_count: Int = 0
        var fg2_miss_count: Int = 0
        var fg3_make_count: Int = 0
        var fg3_miss_count: Int = 0
        var assts_count: Int = 0
        var orebs_count: Int = 0
        var drebs_count: Int = 0
        var steals_count: Int = 0
        var blocks_count: Int = 0
        var defs_count: Int = 0
        var charges_count: Int = 0
        var tos_count: Int = 0

        for liveData in self.allLiveDatas {
            time_cumulative += liveData.time_cumulative
            ft_make_count += liveData.ft_make_count
            ft_miss_count += liveData.ft_miss_count
            fg2_make_count += liveData.fg2_make_count
            fg2_miss_count += liveData.fg2_miss_count
            fg3_make_count += liveData.fg3_make_count
            fg3_miss_count += liveData.fg3_miss_count
            assts_count += liveData.assts_count
            orebs_count += liveData.orebs_count
            drebs_count += liveData.drebs_count
            steals_count += liveData.steals_count
            blocks_count += liveData.blocks_count
            defs_count += liveData.defs_count
            charges_count += liveData.charges_count
            tos_count += liveData.tos_count
        }
        
        self.totalData?.time_cumulative = time_cumulative
        self.totalData?.ft_make_count = ft_make_count
        self.totalData?.ft_miss_count = ft_miss_count
        self.totalData?.fg2_make_count = fg2_make_count
        self.totalData?.fg2_miss_count = fg2_miss_count
        self.totalData?.fg3_make_count = fg3_make_count
        self.totalData?.fg3_miss_count = fg3_miss_count
        self.totalData?.assts_count = assts_count
        self.totalData?.orebs_count = orebs_count
        self.totalData?.drebs_count = drebs_count
        self.totalData?.steals_count = steals_count
        self.totalData?.blocks_count = blocks_count
        self.totalData?.defs_count = defs_count
        self.totalData?.charges_count = charges_count
        self.totalData?.tos_count = tos_count
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
            self.tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: bottom),
            self.tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: leading),
            self.tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: trailing),
        ])
        
        // 去掉行线
//        self.tableView.separatorStyle = .none
    }
    
    // MARK: - Table parameters
    // Table layout parameters
    let leading = CGFloat(8)
    let trailing = CGFloat(-8)
    let bottom = CGFloat(-8)

    // Table row size parameter
    var height_row: CGFloat = 35
    let height_header: CGFloat = 25
    var height_footer: CGFloat = 25
    let width_vertical_divider = CGFloat(1.5)

    // Header Words
    let headerWords = ["PLAYER", "NUMBER", "MINUTES", "PER", "POINTS", "FT", "2FG", "3FG", "eFG%", "ASSTS", "OREBS", "DREBS", "STEALS", "BLOCKS", "DEFS", "CHARGES", "TOS"]
    
    /// players
    func doSelectPlayerNumbers(_ playerNumbers: [String]) {
        
        for (index, liveData) in self.allLiveDatas.enumerated() {
            if playerNumbers.contains(liveData.number!) {
                self.allLiveDatas[index].isOnCourt = true
            } else {
                self.allLiveDatas[index].isOnCourt = false
            }
        }
        
        tableView.reloadData()
    }
}

