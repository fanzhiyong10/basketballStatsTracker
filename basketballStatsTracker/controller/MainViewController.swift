//
//  MainViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/7.
//

import UIKit

/**
 # 延时器
 1. 精度：纳秒
 2. 异步处理
 DispatchTime represents a point in time relative to the default clock with nanosecond precision. On Apple platforms, the default clock is based on the Mach absolute time unit.
 */
func delay(_ delay:Double, closure:@escaping ()->()) {
    /**
     # 当前时间 + 延时（以秒为单位）
     1. 当前时间：DispatchTime.now()
     2. 延时数：double，以秒为单位
     */
    let when = DispatchTime.now() + delay
    
    /**
     # 延时到后，启动进程
     1. 线程池，主队列
     2. DispatchWorkItem：closure
     
     DispatchQueue manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system.
     DispatchWorkItem encapsulates work that can be performed. A work item can be dispatched onto a DispatchQueue and within a DispatchGroup. A DispatchWorkItem can also be set as a DispatchSource event, registration, or cancel handler.
     */
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}


extension Notification.Name {
    static let voiceCommand = Notification.Name("voiceCommand")
}

/// main interface
///
/// content: 2 areas
/// - top area
/// - tableview
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override var prefersStatusBarHidden: Bool {return true}
    
    // game parameter
//    var gameTotalDuration: Float = 48 * 60 // seconds
    var gameStartTime: Date?
    var game_time_remaining: Float = 23 * 60 + 45
//    var game_cum_duration: Float = 48 * 60 - (23 * 60 + 45) // 比赛进行了多长时间，用于记录。 how long the game was on, for the record
    
    // 比赛计时器，每个1秒钟更新一次（重复），1）点击start开始，2）点击stop停止，3）如果game_time_remaining <= 0，停止。
    // Game timer, updated every 1 second (repeated), 1) hit start to start, 2) hit stop to stop, 3) if game_time_remaining <= 0, stop.
    var timer_game: Timer?
    
    @objc func startGame() {
        print("startGame()")
        
        self.startButton.isHidden = true
        self.stopButton.isHidden = false
        
        // record
        // 1) game
        // 2) players on the court
        
        self.timer_game = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(calGameCumDuration), userInfo: nil, repeats: true)
    }
    
    @objc func calGameCumDuration() {
//        self.game_cum_duration += 1.0
        
        self.game_time_remaining -= 1.0
        
        // modify show
        self.gameClockLabel.text = self.calGameClock()
    }
    
    @objc func stopGame() {
        print("stopGame()")
        
        self.startButton.isHidden = false
        self.stopButton.isHidden = true
        
        // record
        // 1) game
        // 2) players on the court

        self.timer_game?.invalidate()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.overrideUserInterfaceStyle = .light // mode
        
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

        self.addSpeechCommand()
    }
    
    var speechCommand: SpeechToMe?
    
    // 实际上，就是限制1分钟。因此使用定时器，重复启动
    var startedSTT = true
    
    var timerSST: Timer?
    
    // 语音控制
    func speechControl() {
        self.speechCommand = SpeechToMe13()
        
        // 启动
        speechCommand?.speechRecognize()
        
        // 避免1分钟
        self.timerSST = Timer.scheduledTimer(timeInterval: 55.0, target: self, selector: #selector(self.fireTime), userInfo: nil, repeats: true)
    }
    
    @objc func fireTime()
    {
        if(startedSTT) {
            let info = "到时，startedSTT == true)"
            print(info)
            self.speechCommand?.stop()
            
            startedSTT = false
        }
        
        // restart it
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startedSTT = true
            
            self.speechCommand = SpeechToMe13()
            
            // 启动
            self.speechCommand?.speechRecognize()
        }
    }
    
    func speechControlOld() {
        self.speechCommand = SpeechToMe13()
        
        // 启动
        speechCommand?.speechRecognize()
    }
    
    /// 声控指令
    private func addSpeechCommand() {
        NotificationCenter.default.addObserver(self, selector: #selector(processVoiceCommand), name: .voiceCommand, object: nil)
    }
    
    @objc func processVoiceCommand() {
        print("processVoiceCommand()")
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
    
    var cell = UITableViewCell()

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

