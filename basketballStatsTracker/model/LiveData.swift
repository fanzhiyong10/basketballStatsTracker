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
        var liveDatas = [LiveData]()
        
        var liveData = LiveData()
        liveData.player = "Ben"
        liveData.number = "23"
        liveData.time_cumulative = 240
        liveData.ft_make_count = 4
        liveData.ft_miss_count = 4

        liveData.fg2_make_count = 7
        liveData.fg2_miss_count = 5
        
        liveData.fg3_make_count = 3
        liveData.fg3_miss_count = 7
        
        liveData.assts_count = 1
        liveData.orebs_count = 1
        liveData.drebs_count = 1
        liveData.steals_count = 1
        liveData.blocks_count = 1
        liveData.defs_count = 1
        liveData.charges_count = 1
        liveData.tos_count = 1
        liveDatas.append(liveData)
        

        do {
            var liveData = LiveData()
            liveData.player = "Dusty"
            liveData.number = "34"
            liveData.time_cumulative = 203
            liveData.ft_make_count = 3
            liveData.ft_miss_count = 7

            liveData.fg2_make_count = 4
            liveData.fg2_miss_count = 8
            
            liveData.fg3_make_count = 6
            liveData.fg3_miss_count = 7
            
            liveData.assts_count = 2
            liveData.orebs_count = 2
            liveData.drebs_count = 2
            liveData.steals_count = 2
            liveData.blocks_count = 2
            liveData.defs_count = 2
            liveData.charges_count = 2
            liveData.tos_count = 2
            
            liveData.isOnCourt = false
            
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Dante"
            liveData.number = "22"
            liveData.time_cumulative = 6 * 60 + 33
            liveData.ft_make_count = 4
            liveData.ft_miss_count = 6

            liveData.fg2_make_count = 5
            liveData.fg2_miss_count = 8
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 3
            liveData.orebs_count = 3
            liveData.drebs_count = 3
            liveData.steals_count = 3
            liveData.blocks_count = 3
            liveData.defs_count = 3
            liveData.charges_count = 3
            liveData.tos_count = 3
            
            liveData.isOnCourt = true
            
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Reid"
            liveData.number = "11"
            liveData.time_cumulative = 8 * 60 + 23
            liveData.ft_make_count = 5
            liveData.ft_miss_count = 5

            liveData.fg2_make_count = 3
            liveData.fg2_miss_count = 12
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Jerrod"
            liveData.number = "55"
            liveData.time_cumulative = 4 * 60 + 34
            liveData.ft_make_count = 4
            liveData.ft_miss_count = 5

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 4
            liveData.fg3_miss_count = 8
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            
            liveData.isOnCourt = true
            
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Jayden"
            liveData.number = "66"
            liveData.time_cumulative = 2 * 60 + 22
            liveData.ft_make_count = 6
            liveData.ft_miss_count = 7

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            
            liveData.isOnCourt = true
            
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Luka"
            liveData.number = "77"
            liveData.time_cumulative = 5 * 60 + 30
            liveData.ft_make_count = 7
            liveData.ft_miss_count = 5

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Blas"
            liveData.number = "88"
            liveData.time_cumulative = 4 * 60
            liveData.ft_make_count = 4
            liveData.ft_miss_count = 8

            liveData.fg2_make_count = 4
            liveData.fg2_miss_count = 8
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            
            liveData.isOnCourt = true
            
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Aaron"
            liveData.number = "99"
            liveData.time_cumulative = 3 * 60 + 23
            liveData.ft_make_count = 5
            liveData.ft_miss_count = 8

            liveData.fg2_make_count = 5
            liveData.fg2_miss_count = 8
            
            liveData.fg3_make_count = 4
            liveData.fg3_miss_count = 8
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Ethan"
            liveData.number = "98"
            liveData.time_cumulative = 4 * 60
            liveData.ft_make_count = 3
            liveData.ft_miss_count = 12

            liveData.fg2_make_count = 3
            liveData.fg2_miss_count = 12
            
            liveData.fg3_make_count = 3
            liveData.fg3_miss_count = 7
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            
            liveData.isOnCourt = true
            
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Tyler"
            liveData.number = "76"
            liveData.time_cumulative = 3 * 60 + 23
            liveData.ft_make_count = 7
            liveData.ft_miss_count = 5

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 6
            liveData.fg3_miss_count = 7
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Logan"
            liveData.number = "54"
            liveData.time_cumulative = 6 * 60 + 33
            liveData.ft_make_count = 7
            liveData.ft_miss_count = 5

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Lucas"
            liveData.number = "32"
            liveData.time_cumulative = 8 * 60 + 23
            liveData.ft_make_count = 4
            liveData.ft_miss_count = 8

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Sam"
            liveData.number = "96"
            liveData.time_cumulative = 4 * 60 + 34
            liveData.ft_make_count = 7
            liveData.ft_miss_count = 5

            liveData.fg2_make_count = 4
            liveData.fg2_miss_count = 8
            
            liveData.fg3_make_count = 4
            liveData.fg3_miss_count = 8
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Caleb"
            liveData.number = "84"
            liveData.time_cumulative = 2 * 60 + 22
            liveData.ft_make_count = 4
            liveData.ft_miss_count = 8

            liveData.fg2_make_count = 5
            liveData.fg2_miss_count = 8
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
        
        do {
            var liveData = LiveData()
            liveData.player = "Bryson"
            liveData.number = "83"
            liveData.time_cumulative = 5 * 60 + 30
            liveData.ft_make_count = 5
            liveData.ft_miss_count = 8

            liveData.fg2_make_count = 3
            liveData.fg2_miss_count = 12
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
                
        do {
            var liveData = LiveData()
            liveData.player = "Matthew"
            liveData.number = "62"
            liveData.time_cumulative = 5 * 60 + 30
            liveData.ft_make_count = 3
            liveData.ft_miss_count = 12

            liveData.fg2_make_count = 7
            liveData.fg2_miss_count = 5
            
            liveData.fg3_make_count = 7
            liveData.fg3_miss_count = 5
            
            liveData.assts_count = 4
            liveData.orebs_count = 4
            liveData.drebs_count = 4
            liveData.steals_count = 4
            liveData.blocks_count = 4
            liveData.defs_count = 4
            liveData.charges_count = 4
            liveData.tos_count = 4
            liveDatas.append(liveData)
        }
                
        return liveDatas
    }
    
    static func createTotalData() -> LiveData {
        var liveData = LiveData()
        liveData.player = "TOTALS"
        liveData.number = ""
        liveData.time_cumulative = 86*60+23
        liveData.ft_make_count = 4
        liveData.ft_miss_count = 4

        liveData.fg2_make_count = 7
        liveData.fg2_miss_count = 5
        
        liveData.fg3_make_count = 3
        liveData.fg3_miss_count = 7
        
        liveData.assts_count = 1
        liveData.orebs_count = 1
        liveData.drebs_count = 1
        liveData.steals_count = 1
        liveData.blocks_count = 1
        liveData.defs_count = 1
        liveData.charges_count = 1
        liveData.tos_count = 1
        
        return liveData
    }
    
    static func newGameData() -> [LiveData] {
        let liveDatas_tmp = createData()
        
        var liveDatas_new = [LiveData]()
        for tmp in liveDatas_tmp {
            var ld = LiveData()
            ld.player = tmp.player
            ld.number = tmp.number
            ld.isOnCourt = tmp.isOnCourt
            
            liveDatas_new.append(ld)
        }
        
        return liveDatas_new
    }
}
