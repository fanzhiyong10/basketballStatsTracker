//
//  MainViewControllerExtStatsTableUI.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/8.
//

import UIKit

extension MainViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 行高动态变化
        var height = self.view.bounds.height
        height -= self.topContentView.bounds.height
        height -= self.height_header
        height += bottom
        
        var lines = 18 // Up to 18 lines
        
        if self.allLiveDatas.count < 17 {
            lines = self.allLiveDatas.count + 1
        } else {
            lines = 18
        }
        
        height /= CGFloat(lines)
        
        height_row = height
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allLiveDatas.count
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        let inset = UIEdgeInsets.zero
        cell.separatorInset = inset

        cell.accessoryType = .none
        
        let font = UIFont.systemFont(ofSize: 10)
        if cell.viewWithTag(101) == nil {
            let width = (self.view.bounds.width - 16) / CGFloat(headerWords.count)

            var aRect = CGRect(x: 8, y: 0, width: width, height: height_row)

            do {
                // vertical divider between cells
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
                let lab = MyLabel(frame: aRect)
                lab.tag = 100
                lab.font = font
                lab.text = "PLAYER"
                lab.textColor = .black
                lab.textAlignment = .left
                cell.contentView.addSubview(lab)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 101
                lab.font = font
                lab.text = "NUMBER"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // vertical divider between cells
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
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
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
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
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
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
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 105
                lab.font = font
                lab.text = "ft"
                lab.textColor = .black
                lab.textAlignment = .center
                lab.numberOfLines = 2
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 106
                lab.font = font
                lab.text = "fg2"
                lab.textColor = .black
                lab.textAlignment = .center
                lab.numberOfLines = 2
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 107
                lab.font = font
                lab.text = "fg3"
                lab.textColor = .black
                lab.textAlignment = .center
                lab.numberOfLines = 2
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
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
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 109
                lab.font = font
                lab.text = "assts"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 110
                lab.font = font
                lab.text = "orebs"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 111
                lab.font = font
                lab.text = "drebs"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 112
                lab.font = font
                lab.text = "steals"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 113
                lab.font = font
                lab.text = "blocks"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 114
                lab.font = font
                lab.text = "defs"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
                lab.tag = 115
                lab.font = font
                lab.text = "charges"
                lab.textColor = .black
                lab.textAlignment = .center
                cell.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_row
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                cell.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = MyLabel(frame: aRect)
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
            let lab = cell.contentView.viewWithTag(100) as! MyLabel
            lab.text = String(liveData.player!)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapPlayer))
            lab.addGestureRecognizer(tap)
            
            if liveData.isOnCourt {
                lab.textColor = .systemGreen
                let font = UIFont.systemFont(ofSize: 18, weight: .bold)
                lab.font = font
                lab.frame.origin.x = 2
                lab.sizeToFit()
            } else {
                lab.textColor = .black
                lab.font = font
                lab.frame.origin.x = 8
            }
        }
        
        do {
            let lab = cell.contentView.viewWithTag(101) as! MyLabel
            lab.text = String(liveData.number!)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapNumber))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(102) as! UILabel
            lab.text = String(liveData.minutes)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(103) as! UILabel
            lab.text = String(liveData.per)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(104) as! UILabel
            lab.text = String(liveData.points)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(105) as! MyLabel
            lab.text = String(liveData.ft)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapFT))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(106) as! MyLabel
            lab.text = String(liveData.fg2)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapFG2))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(107) as! MyLabel
            lab.text = String(liveData.fg3)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapFG3))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(108) as! UILabel
            lab.text = String(liveData.eFG)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(109) as! MyLabel
            lab.text = String(liveData.assts)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAssts))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(110) as! MyLabel
            lab.text = String(liveData.orebs)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapOrebs))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(111) as! MyLabel
            lab.text = String(liveData.drebs)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapDrebs))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(112) as! MyLabel
            lab.text = String(liveData.steals)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapSteals))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(113) as! MyLabel
            lab.text = String(liveData.blocks)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapBlocks))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(114) as! MyLabel
            lab.text = String(liveData.defs)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapDefs))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(115) as! MyLabel
            lab.text = String(liveData.charges)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCharges))
            lab.addGestureRecognizer(tap)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(116) as! MyLabel
            lab.text = String(liveData.tos)
            
            lab.indexPath = indexPath
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapTos))
            lab.addGestureRecognizer(tap)
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
        return height_header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView( withIdentifier: self.headerID)!

        let font = UIFont.systemFont(ofSize: 10)

        if headerView.viewWithTag(1000) == nil {
            let width = (self.view.bounds.width - 16) / CGFloat(headerWords.count) // 间距1

            var aRect = CGRect(x: 8, y: 0, width: width, height: height_header)

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
                    bRect.size.width = width_vertical_divider
                    bRect.size.height = height_header
                    bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                    bRect.origin.y = 0
                    let view = UIView(frame: bRect)
                    view.backgroundColor = UIColor.white
                    
                    headerView.contentView.addSubview(view)
                }
                
            }
        }
        
        headerView.contentView.backgroundColor = UIColor.systemBlue
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height = self.view.bounds.height
        height -= self.topContentView.bounds.height
        height -= self.height_header
        height -= 20
        
        var lines = 18 // Up to 18 lines
        
        if self.allLiveDatas.count < 17 {
            lines = self.allLiveDatas.count + 1
        } else {
            lines = 18
        }
        
        height /= CGFloat(lines)
        
        height_footer = height
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView( withIdentifier: self.footerID)!
        // backgroundColor
        footerView.backgroundView = UIView()
        footerView.backgroundView?.backgroundColor = .white
        
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let textColor = UIColor.white
        
        if footerView.viewWithTag(2001) == nil {
            let width = (self.view.bounds.width - 16) / CGFloat(headerWords.count)

            var aRect = CGRect(x: 8, y: 0, width: width, height: height_footer)

            do {
                let lab = UILabel(frame: aRect)
                lab.tag = 2000
                lab.font = font
                lab.text = "PLAYER"
                lab.textColor = textColor
                lab.textAlignment = .left
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2001
                lab.font = font
                lab.text = "NUMBER"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2002
                lab.font = font
                lab.text = "minutes"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2003
                lab.font = font
                lab.text = "per"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2004
                lab.font = font
                lab.text = "points"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2005
                lab.font = font
                lab.text = "ft"
                lab.textColor = textColor
                lab.textAlignment = .center
                lab.numberOfLines = 2
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2006
                lab.font = font
                lab.text = "fg2"
                lab.textColor = textColor
                lab.textAlignment = .center
                lab.numberOfLines = 2
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2007
                lab.font = font
                lab.text = "fg3"
                lab.textColor = textColor
                lab.textAlignment = .center
                lab.numberOfLines = 2
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2008
                lab.font = font
                lab.text = "eFG"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2009
                lab.font = font
                lab.text = "assts"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2010
                lab.font = font
                lab.text = "orebs"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2011
                lab.font = font
                lab.text = "drebs"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2012
                lab.font = font
                lab.text = "steals"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2013
                lab.font = font
                lab.text = "blocks"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2014
                lab.font = font
                lab.text = "defs"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2015
                lab.font = font
                lab.text = "charges"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
                
                // 最后一个，没有分割线
                var bRect = aRect
                bRect.size.width = width_vertical_divider
                bRect.size.height = height_footer
                bRect.origin.x = aRect.origin.x + aRect.width - width_vertical_divider
                bRect.origin.y = 0
                let view = UIView(frame: bRect)
                view.backgroundColor = UIColor.white
                
                footerView.contentView.addSubview(view)
            }

            do {
                aRect.origin.x += width
                
                let lab = UILabel(frame: aRect)
                lab.tag = 2016
                lab.font = font
                lab.text = "tos"
                lab.textColor = textColor
                lab.textAlignment = .center
                footerView.contentView.addSubview(lab)
            }
        }
        
        let liveData = self.totalData!
        
        do {
            let lab = footerView.contentView.viewWithTag(2000) as! UILabel
            lab.text = String(liveData.player!)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2001) as! UILabel
            lab.text = String(liveData.number!)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2002) as! UILabel
            lab.text = String(liveData.minutes)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2003) as! UILabel
            lab.text = String(liveData.per)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2004) as! UILabel
            lab.text = String(liveData.points)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2005) as! UILabel
            lab.text = String(liveData.ft)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2006) as! UILabel
            lab.text = String(liveData.fg2)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2007) as! UILabel
            lab.text = String(liveData.fg3)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2008) as! UILabel
            lab.text = String(liveData.eFG)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2009) as! UILabel
            lab.text = String(liveData.assts)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2010) as! UILabel
            lab.text = String(liveData.orebs)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2011) as! UILabel
            lab.text = String(liveData.drebs)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2012) as! UILabel
            lab.text = String(liveData.steals)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2013) as! UILabel
            lab.text = String(liveData.blocks)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2014) as! UILabel
            lab.text = String(liveData.defs)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2015) as! UILabel
            lab.text = String(liveData.charges)
        }
        
        do {
            let lab = footerView.contentView.viewWithTag(2016) as! UILabel
            lab.text = String(liveData.tos)
        }
        
        footerView.contentView.backgroundColor = UIColor.systemGray
        
        
        return footerView
    }
}


class MyLabel: UILabel {
    var indexPath: IndexPath?
}
