//
//  ClockPickViewController.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/12.
//

import UIKit

class ClockPickViewController: UIViewController {
    // 入参：
    var game_cum_duration: Float = 0 // seconds

    private var hours: Int = 48
    private var minutes: Int = 48
    private var seconds: Int = 0

    private var hours_default: Int = 0
    private var minutes_default: Int = 0
    private var seconds_default: Int = 0
    
    // 显示配置
    var values_hour: [String] = ["00", "01", "02", "03", "04", "05"]
    var values_minute: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09"]
    var values_second: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09"]

    var picker : UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createDatas()
        self.processData()
        // Do any additional setup after loading the view.
        self.createNavigatorBar()

        self.createInterface()
        
        self.picker.selectRow(hours_default, inComponent: 0, animated: true)
        self.picker.selectRow(minutes_default, inComponent: 1, animated: true)
        self.picker.selectRow(seconds_default, inComponent: 2, animated: true)
    }
    
    func createNavigatorBar() {
        let image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        
        let close_item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeWindow))
        self.navigationItem.leftBarButtonItem = close_item
        
        
        // ===== right
        let title = NSMutableAttributedString(string:"DONE", attributes:[
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ])
        let aRect = CGRect(origin: CGPoint(), size: CGSize(width: 80, height: 30))
        let doneButton = UIButton(frame: aRect)
        doneButton.contentHorizontalAlignment = .right
        doneButton.setAttributedTitle(title, for: .normal)
        
        doneButton.addTarget(self, action: #selector(doneSelected), for: .touchUpInside)
        
        let done_item = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = done_item
    }
    
    @objc func closeWindow() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    var doneIsRight = false // selected player is right
    
    /// Done
    ///
    /// action
    /// - 传递数据
    @objc func doneSelected() {
        self.doneIsRight = true
        
        self.dismiss(animated: true)
    }
    
    func createDatas() {
        self.values_hour = [String]()
        for index in 0...5 {
            let str = String(format: "%02d", index)
            self.values_hour.append(str)
        }
        
        self.values_minute = [String]()
        for index in 0...59 {
            let str = String(format: "%02d", index)
            self.values_minute.append(str)
        }
        
        self.values_second = self.values_minute
    }
    
    func processData() {
        self.hours = Int(self.game_cum_duration / 3600)
        self.minutes = Int((self.game_cum_duration - Float(hours) * 3600) / 60)
        self.seconds = Int(self.game_cum_duration - Float(hours) * 3600 - Float(minutes * 60))
        
        self.hours_default = self.hours
        self.minutes_default = self.minutes
        self.seconds_default = self.seconds
    }
    
    var hoursLabel: UILabel!
    
    func createInterface() {
        self.createLabel()

        self.createPicker()
    }
    
    func createLabel() {
        let font = UIFont.systemFont(ofSize: 36)
        // label: hours, minutes, seconds
        let hoursLabel = UILabel()
        hoursLabel.text = "Hours"
        hoursLabel.textAlignment = .center
        hoursLabel.font = font
        hoursLabel.textColor = .darkGray
        
        self.view.addSubview(hoursLabel)
        self.hoursLabel = hoursLabel
        
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        var safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            hoursLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            hoursLabel.widthAnchor.constraint(equalToConstant: 140),
            hoursLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let minutesLabel = UILabel()
        minutesLabel.text = "Minutes"
        minutesLabel.textAlignment = .center
        minutesLabel.font = font
        minutesLabel.textColor = .darkGray
        
        self.view.addSubview(minutesLabel)
        
        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
//        var safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            minutesLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            minutesLabel.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            minutesLabel.widthAnchor.constraint(equalToConstant: 140),
            minutesLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let secondsLabel = UILabel()
        secondsLabel.text = "Seconds"
        secondsLabel.textAlignment = .center
        secondsLabel.font = font
        secondsLabel.textColor = .darkGray
        
        self.view.addSubview(secondsLabel)
        
        secondsLabel.translatesAutoresizingMaskIntoConstraints = false
        safe = minutesLabel.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            secondsLabel.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            secondsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            secondsLabel.widthAnchor.constraint(equalTo: safe.widthAnchor),
            secondsLabel.heightAnchor.constraint(equalTo: safe.heightAnchor)
        ])
    }
    
    func createPicker() {
        self.picker = UIPickerView()
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.view.addSubview(self.picker)
        
        self.picker.translatesAutoresizingMaskIntoConstraints = false
        
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.picker.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.picker.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -0),
            self.picker.topAnchor.constraint(equalTo: self.hoursLabel.bottomAnchor, constant: 0),
            self.picker.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: 0),
        ])
    }
    
    weak var delegate: SetGameClockDelegate?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.doneIsRight {
            self.delegate?.doSetGameClock(hours, minutes, seconds)
        }
    }

}

extension ClockPickViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.values_hour.count
        case 1:
            return self.values_minute.count
        case 2:
            return self.values_second.count
        default:
            break
        }
        
        return self.values_hour.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            print(self.values_hour[row])
            self.hours = Int(self.values_hour[row])!
        case 1:
            print(self.values_minute[row])
            self.minutes = Int(self.values_minute[row])!

        case 2:
            print(self.values_second[row])
            self.seconds = Int(self.values_second[row])!

        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let lab = UILabel()
        
        switch component {
        case 0:
            lab.text = self.values_hour[row]
            
        case 1:
            print(self.values_minute[row])
            lab.text = self.values_minute[row]
            
        case 2:
            print(self.values_second[row])
            lab.text = self.values_second[row]
            
        default:
            break
        }

        lab.backgroundColor = .clear
        lab.textColor = .systemRed
        lab.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        lab.sizeToFit()
        
        return lab
    }
}

extension ClockPickViewController : UIPopoverPresentationControllerDelegate {
    func popoverPresentationControllerShouldDismissPopover(
        _ pop: UIPopoverPresentationController) -> Bool {
        // 点击：窗口外部，允许消失
        return pop.presentedViewController.presentedViewController == nil
    }
    
    func popoverPresentationControllerDidDismissPopover(_ pop: UIPopoverPresentationController) {
    }
}


extension ClockPickViewController : UINavigationControllerDelegate {
    // deal with content size change bug
    // this bug is evident when you tap the Change Size row and navigate back:
    // the height doesn't change back
    
    func navigationController(_ nc: UINavigationController, didShow vc: UIViewController, animated: Bool) {
        nc.preferredContentSize = vc.preferredContentSize
    }
    
}

protocol SetGameClockDelegate: AnyObject {
    func doSetGameClock(_ hours: Int, _ minutes: Int, _ seconds: Int)
}

extension MainViewController: SetGameClockDelegate {
    func doSetGameClock(_ hours: Int, _ minutes: Int, _ seconds: Int) {
        DispatchQueue.main.async {
            self.game_cum_duration = Float(hours * 3600 + minutes * 60 + seconds)
            
            // modify show
            let title = self.processGameClockTitle()
            self.gameClockButton.setAttributedTitle(title, for: .normal)
        }
    }
}
