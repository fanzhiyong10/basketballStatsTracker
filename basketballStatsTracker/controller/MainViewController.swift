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
    
    /// start game
    ///
    /// guard
    /// - game_time_remaining > 0
    @objc func startGame() {
        print("startGame()")
        
        guard self.game_time_remaining > 0 else {
            self.alertStartGame()
            return
        }
        
        self.startButton.isHidden = true
        self.stopButton.isHidden = false
        
        // record
        // 1) game
        // 2) players on the court
        
        self.timer_game = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    /// game_time_remaining
    func alertStartGame() {
        DispatchQueue.main.async {
            let title = "Please Set Game Clock"
            let message = "Game Clock > 0 when start"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.overrideUserInterfaceStyle = .light
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func countDown() {
//        self.game_cum_duration += 1.0
        DispatchQueue.main.async {
            self.game_time_remaining -= 1.0
            
            let title = self.processGameClockTitle()
            self.gameClockButton.setAttributedTitle(title, for: .normal)
            
            self.countUpPlayersOnCourt()
            
            if self.game_time_remaining <= 0 {
                self.stopGame()
            }
        }
    }
    
    func countUpPlayersOnCourt() {
        // players on court
        for (index, liveData) in self.allLiveDatas.enumerated() {
            if liveData.isOnCourt {
                self.allLiveDatas[index].time_cumulative += 1.0
            }
        }
        
        self.processTotalData()
        
        self.tableView.reloadData()
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
        self.addObserverOfVoiceWordTrain()

        // 1: not speech recognize
        SettingsBundleHelper.saveIsResponseOnSpeechControl(1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // time to load
        self.processPlayerVoiceWords()
        
        self.processNumberVoiceWords()
    }
    
    var speechCommand: SpeechToMe?
    
    // 实际上，就是限制1分钟。因此使用定时器，重复启动
    var startedSTT = true
    
    var timerSST: Timer?
    


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
//    var gameClockLabel: UILabel!
    var gameClockButton: UIButton!
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
        
        self.processTotalData()
    }
    
    var playerVoiceWords: [PlayerVoiceWords]?
    var numberVoiceWords: [NumberVoiceWords]?

    /// only one time
    func processPlayerVoiceWords() {
        self.playerVoiceWords = [PlayerVoiceWords]()
        
        for liveData in self.allLiveDatas {
            if liveData.player == nil {
                continue
            }
            
            let player = liveData.player!
            let speechComandWords = "playerVoiceWords_\(player)"
            var words = [String]()
            words.append(player.lowercased())
            
            if let result = UserDefaults.standard.string(forKey: speechComandWords) {
                // 命令集合处理
                let strs = result.split(separator: ",")
                
                var wordSet = Set<String>()
                for str in strs {
                    wordSet.insert(String(str).lowercased())
                }
                
                for word in wordSet {
                    words.append(word)
                }
            } else {
                UserDefaults.standard.set(player.lowercased(), forKey: speechComandWords)
            }
            
            let pvw = PlayerVoiceWords(player: player, words: words, speechComandWords: speechComandWords)
            
            self.playerVoiceWords?.append(pvw)
        }
    }
    
    /// only one time
    func processNumberVoiceWords() {
        self.numberVoiceWords = [NumberVoiceWords]()
        
        for liveData in self.allLiveDatas {
            if liveData.number == nil {
                continue
            }
            
            let number = liveData.number!
            let speechComandWords = "numberVoiceWords_\(number)"
            var words = [String]()
            words.append(number)
            
            if let result = UserDefaults.standard.string(forKey: speechComandWords) {
                // 命令集合处理
                let strs = result.split(separator: ",")
                
                var wordSet = Set<String>()
                for str in strs {
                    wordSet.insert(String(str).lowercased())
                }
                
                for word in wordSet {
                    words.append(word)
                }
            } else {
                UserDefaults.standard.set(number, forKey: speechComandWords)
            }
            
            let nvw = NumberVoiceWords(number: number, words: words, speechComandWords: speechComandWords)
            
            self.numberVoiceWords?.append(nvw)
        }
    }
    
    func processTotalData() {
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

