//
//  LiveData.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/7.
//

struct LiveData {
    var player: String?
    var number: String?
    var minutes: String?
    var per: String?
    var points: String?
    var ft: String {
        let total = self.ft_make + self.ft_miss
        let percent = Float(self.ft_make) / Float(total) * 100
        let formatted = String(format: "%.1f", percent)
        let str = "\(self.ft_make)/\(total)" + "\n(" + formatted + "%)"
        
        return str
    }
    var ft_make: Int = 0
    var ft_miss: Int = 0
    
    var fg2: String {
        let total = self.fg2_make + self.fg2_miss
        let percent = Float(self.fg2_make) / Float(total) * 100
        let formatted = String(format: "%.1f", percent)
        let str = "\(self.fg2_make)/\(total)" + "\n(" + formatted + "%)"
        
        return str
    }
    var fg2_make: Int = 0
    var fg2_miss: Int = 0
    
    var fg3: String {
        let total = self.fg3_make + self.fg3_miss
        let percent = Float(self.fg3_make) / Float(total) * 100
        let formatted = String(format: "%.1f", percent)
        let str = "\(self.fg3_make)/\(total)" + "\n(" + formatted + "%)"
        
        return str
    }
    var fg3_make: Int = 0
    var fg3_miss: Int = 0
    
    var eFG: String?
    var assts: String?
    var orebs: String?
    var drebs: String?
    var steals: String?
    var blocks: String?
    var defs: String?
    var charges: String?
    var tos: String?

    static func createData() -> [LiveData] {
        var feedBacks = [LiveData]()
        
        var feedBack = LiveData()
        feedBack.player = "Ben"
        feedBack.number = "23"
        feedBack.minutes = "4:00"
        feedBack.per = "23"
        feedBack.points = "23"
//        feedBack.ft = "4/8\n(50.0%)"
        feedBack.ft_make = 4
        feedBack.ft_miss = 4

//        feedBack.fg2 = "7/12\n(58.3%)"
        feedBack.fg2_make = 7
        feedBack.fg2_miss = 5
        
//        feedBack.fg3 = "3/10\n(33.3%)"
        feedBack.fg3_make = 3
        feedBack.fg3_miss = 7
        
        feedBack.eFG = "23.3%"
        feedBack.assts = "1"
        feedBack.orebs = "1"
        feedBack.drebs = "1"
        feedBack.steals = "1"
        feedBack.blocks = "1"
        feedBack.defs = "1"
        feedBack.charges = "1"
        feedBack.tos = "1"
        feedBacks.append(feedBack)
        

        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
//            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "Ben"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        do {
            var feedBack = LiveData()
            feedBack.player = "TOTALS"
            feedBack.number = "23"
            feedBack.minutes = "4:00"
            feedBack.per = "23"
            feedBack.points = "23"
            //            feedBack.ft = "4/8\n(50.0%)"
            feedBack.ft_make = 4
            feedBack.ft_miss = 4

            //        feedBack.fg2 = "7/12\n(58.3%)"
                    feedBack.fg2_make = 7
                    feedBack.fg2_miss = 5
                    
            //        feedBack.fg3 = "3/10\n(33.3%)"
                    feedBack.fg3_make = 3
                    feedBack.fg3_miss = 7
                    
            feedBack.eFG = "23.3%"
            feedBack.assts = "1"
            feedBack.orebs = "1"
            feedBack.drebs = "1"
            feedBack.steals = "1"
            feedBack.blocks = "1"
            feedBack.defs = "1"
            feedBack.charges = "1"
            feedBack.tos = "1"
            feedBacks.append(feedBack)
        }
        
        return feedBacks
    }
}
