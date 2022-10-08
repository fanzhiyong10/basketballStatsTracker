//
//  LiveData.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/7.
//

struct LiveData {
    var player: String?
    var number: String?
    var minutes: String {
        let mins = Int(time_cumulative / 60)
        let secs = Int(time_cumulative) - mins * 60
        let str = "\(mins):" + String(format: "%02d", secs)
        return str
    }
    var time_cumulative: Float = 0
    
    var per: String {
        let str = "\(self.per_cal)"
        return str
    }
    var per_cal: Int {
        var pc = self.points_cal
        pc -= ft_miss_count + fg2_miss_count + fg3_miss_count
        pc += assts_count + orebs_count + drebs_count + steals_count + blocks_count + defs_count + charges_count * 2
        pc -= tos_count * 2
        return pc
    }
    
    var points: String {
        let str = "\(self.points_cal)"
        return str
    }
    var points_cal: Int {
        var pc = self.ft_make_count
        pc += fg2_make_count * 2
        pc += fg3_make_count * 3
        return pc
    }
    
    var ft: String {
        let total = self.ft_make_count + self.ft_miss_count
        let percent = Float(self.ft_make_count) / Float(total) * 100
        let formatted = String(format: "%.1f", percent)
        let str = "\(self.ft_make_count)/\(total)" + "\n(" + formatted + "%)"
        
        return str
    }
    var ft_make_count: Int = 0
    var ft_miss_count: Int = 0
    
    var fg2: String {
        let total = self.fg2_make_count + self.fg2_miss_count
        let percent = Float(self.fg2_make_count) / Float(total) * 100
        let formatted = String(format: "%.1f", percent)
        let str = "\(self.fg2_make_count)/\(total)" + "\n(" + formatted + "%)"
        
        return str
    }
    var fg2_make_count: Int = 0
    var fg2_miss_count: Int = 0
    
    var fg3: String {
        let total = self.fg3_make_count + self.fg3_miss_count
        let percent = Float(self.fg3_make_count) / Float(total) * 100
        let formatted = String(format: "%.1f", percent)
        let str = "\(self.fg3_make_count)/\(total)" + "\n(" + formatted + "%)"
        
        return str
    }
    var fg3_make_count: Int = 0
    var fg3_miss_count: Int = 0
    
    var eFG: String {
        let percent = eFG_cal * 100
        let formatted = String(format: "%.1f", percent)
        let str = formatted + "%"
        
        return str
    }
    var eFG_cal: Float {
        var result: Float = Float(fg2_make_count)
        result += Float(fg3_make_count) * 1.5
        result /= Float(fg2_make_count + fg2_miss_count + fg3_make_count + fg3_miss_count)
        return result
    }
    
    var assts: String {
        let str = "\(self.assts_count)"
        return str
    }
    var assts_count: Int = 0
    
    var orebs: String {
        let str = "\(self.orebs_count)"
        return str
    }
    var orebs_count: Int = 0
    
    var drebs: String {
        let str = "\(self.drebs_count)"
        return str
    }
    var drebs_count: Int = 0
    
    var steals: String {
        let str = "\(self.steals_count)"
        return str
    }
    var steals_count: Int = 0
    
    var blocks: String {
        let str = "\(self.blocks_count)"
        return str
    }
    var blocks_count: Int = 0
    
    var defs: String {
        let str = "\(self.defs_count)"
        return str
    }
    var defs_count: Int = 0
    
    var charges: String {
        let str = "\(self.charges_count)"
        return str
    }
    var charges_count: Int = 0
    
    var tos: String {
        let str = "\(self.tos_count)"
        return str
    }
    var tos_count: Int = 0
    
    var isOnCourt = false

    static func createData() -> [LiveData] {
        var feedBacks = [LiveData]()
        
        var feedBack = LiveData()
        feedBack.player = "Ben"
        feedBack.number = "23"
        feedBack.time_cumulative = 240
        feedBack.ft_make_count = 4
        feedBack.ft_miss_count = 4

        feedBack.fg2_make_count = 7
        feedBack.fg2_miss_count = 5
        
        feedBack.fg3_make_count = 3
        feedBack.fg3_miss_count = 7
        
        feedBack.assts_count = 1
        feedBack.orebs_count = 1
        feedBack.drebs_count = 1
        feedBack.steals_count = 1
        feedBack.blocks_count = 1
        feedBack.defs_count = 1
        feedBack.charges_count = 1
        feedBack.tos_count = 1
        feedBacks.append(feedBack)
        

        do {
            var feedBack = LiveData()
            feedBack.player = "Dusty"
            feedBack.number = "34"
            feedBack.time_cumulative = 203
            feedBack.ft_make_count = 3
            feedBack.ft_miss_count = 7

            feedBack.fg2_make_count = 4
            feedBack.fg2_miss_count = 8
            
            feedBack.fg3_make_count = 6
            feedBack.fg3_miss_count = 7
            
            feedBack.assts_count = 2
            feedBack.orebs_count = 2
            feedBack.drebs_count = 2
            feedBack.steals_count = 2
            feedBack.blocks_count = 2
            feedBack.defs_count = 2
            feedBack.charges_count = 2
            feedBack.tos_count = 2
            
            feedBack.isOnCourt = false
            
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Dante"
            feedBack.number = "22"
            feedBack.time_cumulative = 6 * 60 + 33
            feedBack.ft_make_count = 4
            feedBack.ft_miss_count = 6

            feedBack.fg2_make_count = 5
            feedBack.fg2_miss_count = 8
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 3
            feedBack.orebs_count = 3
            feedBack.drebs_count = 3
            feedBack.steals_count = 3
            feedBack.blocks_count = 3
            feedBack.defs_count = 3
            feedBack.charges_count = 3
            feedBack.tos_count = 3
            
            feedBack.isOnCourt = true
            
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Reid"
            feedBack.number = "11"
            feedBack.time_cumulative = 8 * 60 + 23
            feedBack.ft_make_count = 5
            feedBack.ft_miss_count = 5

            feedBack.fg2_make_count = 3
            feedBack.fg2_miss_count = 12
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Jerrod"
            feedBack.number = "55"
            feedBack.time_cumulative = 4 * 60 + 34
            feedBack.ft_make_count = 4
            feedBack.ft_miss_count = 5

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 4
            feedBack.fg3_miss_count = 8
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            
            feedBack.isOnCourt = true
            
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Jayden"
            feedBack.number = "66"
            feedBack.time_cumulative = 2 * 60 + 22
            feedBack.ft_make_count = 6
            feedBack.ft_miss_count = 7

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            
            feedBack.isOnCourt = true
            
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Luka"
            feedBack.number = "77"
            feedBack.time_cumulative = 5 * 60 + 30
            feedBack.ft_make_count = 7
            feedBack.ft_miss_count = 5

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Blas"
            feedBack.number = "88"
            feedBack.time_cumulative = 4 * 60
            feedBack.ft_make_count = 4
            feedBack.ft_miss_count = 8

            feedBack.fg2_make_count = 4
            feedBack.fg2_miss_count = 8
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            
            feedBack.isOnCourt = true
            
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Aaron"
            feedBack.number = "99"
            feedBack.time_cumulative = 3 * 60 + 23
            feedBack.ft_make_count = 5
            feedBack.ft_miss_count = 8

            feedBack.fg2_make_count = 5
            feedBack.fg2_miss_count = 8
            
            feedBack.fg3_make_count = 4
            feedBack.fg3_miss_count = 8
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ethan"
            feedBack.number = "98"
            feedBack.time_cumulative = 4 * 60
            feedBack.ft_make_count = 3
            feedBack.ft_miss_count = 12

            feedBack.fg2_make_count = 3
            feedBack.fg2_miss_count = 12
            
            feedBack.fg3_make_count = 3
            feedBack.fg3_miss_count = 7
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            
            feedBack.isOnCourt = true
            
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Tyler"
            feedBack.number = "76"
            feedBack.time_cumulative = 3 * 60 + 23
            feedBack.ft_make_count = 7
            feedBack.ft_miss_count = 5

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 6
            feedBack.fg3_miss_count = 7
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Logan"
            feedBack.number = "54"
            feedBack.time_cumulative = 6 * 60 + 33
            feedBack.ft_make_count = 7
            feedBack.ft_miss_count = 5

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Lucas"
            feedBack.number = "32"
            feedBack.time_cumulative = 8 * 60 + 23
            feedBack.ft_make_count = 4
            feedBack.ft_miss_count = 8

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Sam"
            feedBack.number = "96"
            feedBack.time_cumulative = 4 * 60 + 34
            feedBack.ft_make_count = 7
            feedBack.ft_miss_count = 5

            feedBack.fg2_make_count = 4
            feedBack.fg2_miss_count = 8
            
            feedBack.fg3_make_count = 4
            feedBack.fg3_miss_count = 8
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Caleb"
            feedBack.number = "84"
            feedBack.time_cumulative = 2 * 60 + 22
            feedBack.ft_make_count = 4
            feedBack.ft_miss_count = 8

            feedBack.fg2_make_count = 5
            feedBack.fg2_miss_count = 8
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Bryson"
            feedBack.number = "83"
            feedBack.time_cumulative = 5 * 60 + 30
            feedBack.ft_make_count = 5
            feedBack.ft_miss_count = 8

            feedBack.fg2_make_count = 3
            feedBack.fg2_miss_count = 12
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
                
        do {
            var feedBack = LiveData()
            feedBack.player = "Matthew"
            feedBack.number = "62"
            feedBack.time_cumulative = 5 * 60 + 30
            feedBack.ft_make_count = 3
            feedBack.ft_miss_count = 12

            feedBack.fg2_make_count = 7
            feedBack.fg2_miss_count = 5
            
            feedBack.fg3_make_count = 7
            feedBack.fg3_miss_count = 5
            
            feedBack.assts_count = 4
            feedBack.orebs_count = 4
            feedBack.drebs_count = 4
            feedBack.steals_count = 4
            feedBack.blocks_count = 4
            feedBack.defs_count = 4
            feedBack.charges_count = 4
            feedBack.tos_count = 4
            feedBacks.append(feedBack)
        }
                
        return feedBacks
    }
    
    static func createTotalData() -> LiveData {
        var feedBack = LiveData()
        feedBack.player = "TOTALS"
        feedBack.number = ""
        feedBack.time_cumulative = 86*60+23
        feedBack.ft_make_count = 4
        feedBack.ft_miss_count = 4

        feedBack.fg2_make_count = 7
        feedBack.fg2_miss_count = 5
        
        feedBack.fg3_make_count = 3
        feedBack.fg3_miss_count = 7
        
        feedBack.assts_count = 1
        feedBack.orebs_count = 1
        feedBack.drebs_count = 1
        feedBack.steals_count = 1
        feedBack.blocks_count = 1
        feedBack.defs_count = 1
        feedBack.charges_count = 1
        feedBack.tos_count = 1
        
        return feedBack
    }
}
