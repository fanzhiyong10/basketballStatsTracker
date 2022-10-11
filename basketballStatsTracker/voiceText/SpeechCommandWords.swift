//
//  SpeechCommandWords.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/9.
//

import Foundation

extension Notification.Name {
    static let toMake = Notification.Name("toMake")
    static let toMiss = Notification.Name("toMiss")
    static let toBucket = Notification.Name("toBucket")
    static let toBrick = Notification.Name("toBrick")
    static let toSwish = Notification.Name("toSwish")
    static let toOff = Notification.Name("toOff")
    static let toBoard = Notification.Name("toBoard")
    static let toGlass = Notification.Name("toGlass")
    static let toDime = Notification.Name("toDime")
    static let toBad = Notification.Name("toBad")
    static let toSteal = Notification.Name("toSteal")
    static let toBlock = Notification.Name("toBlock")
    static let toTip = Notification.Name("toTip")
    static let toCharge = Notification.Name("toCharge")
}

struct SpeechCommandWords {
    static func addSaved(_ keyName: String, strArr: inout [String])  {
        // 读出存储的命令集合
        if let result = UserDefaults.standard.string(forKey: keyName) {
            // 命令集合处理
            let strs = result.split(separator: ",")
            
            for tmp in strs {
                let aStr = String(tmp)
                if strArr.contains(aStr) {
                    continue
                }
                // 没有则添加
                strArr.append(aStr)
            }
        }
    }
    
    static var toMake: [String] {
        var strArr = ["make"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_0"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toMiss: [String] {
        var strArr = ["miss"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_1"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toBucket: [String] {
        var strArr = ["bucket"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_2"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toBrick: [String] {
        var strArr = ["brick"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_3"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toSwish: [String] {
        var strArr = ["swish"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_4"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toOff: [String] {
        var strArr = ["off"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_5"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toBoard: [String] {
        var strArr = ["board"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_6"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toGlass: [String] {
        var strArr = ["glass"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_7"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toDime: [String] {
        var strArr = ["dime"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_8"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toBad: [String] {
        var strArr = ["bad"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_9"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toSteal: [String] {
        var strArr = ["steal"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_10"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toBlock: [String] {
        var strArr = ["block"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_11"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toTip: [String] {
        var strArr = ["tip"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_12"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
    static var toCharge: [String] {
        var strArr = ["charge"]
        
        var speechComandWords = "speechComandWords"
        speechComandWords += "_13"
        // _0
        let a00 = speechComandWords + "_0"

        addSaved(a00, strArr: &strArr)

        return strArr
    }
    
}
