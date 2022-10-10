//
//  MainViewControllerExtTableAction.swift
//  basketballStatsTracker
//
//  Created by 范志勇 on 2022/10/10.
//

import UIKit

extension MainViewController {
    @objc func tapPlayer(_ tap: UITapGestureRecognizer) {
        print("tapPlayer(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }
    
    @objc func tapNumber(_ tap: UITapGestureRecognizer) {
        print("tapNumber(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetNumberViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    
    @objc func tapAssts(_ tap: UITapGestureRecognizer) {
        print("tapAssts(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetAsstsViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapOrebs(_ tap: UITapGestureRecognizer) {
        print("tapOrebs(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapDrebs(_ tap: UITapGestureRecognizer) {
        print("tapDrebs(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapSteals(_ tap: UITapGestureRecognizer) {
        print("tapSteals(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapBlocks(_ tap: UITapGestureRecognizer) {
        print("tapBlocks(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapDefs(_ tap: UITapGestureRecognizer) {
        print("tapDefs(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapCharges(_ tap: UITapGestureRecognizer) {
        print("tapCharges(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapTos(_ tap: UITapGestureRecognizer) {
        print("tapTos(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapFT(_ tap: UITapGestureRecognizer) {
        print("tapFT(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapFG2(_ tap: UITapGestureRecognizer) {
        print("tapFG2(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }

    @objc func tapFG3(_ tap: UITapGestureRecognizer) {
        print("tapFG3(_ tap: UITapGestureRecognizer)")
        guard let myLabel = tap.view as? MyLabel else {
            return
        }
        
        print("\(myLabel.indexPath!.row)")
        
        let vc = SetPlayersViewController()
        vc.liveData = self.allLiveDatas[myLabel.indexPath!.row]
        vc.indexPath = myLabel.indexPath
        vc.delegate = self
        
        var size = self.view.bounds.size
        size.height = 200
        size.width = 500
        vc.preferredContentSize = size
        vc.view.frame = CGRect(origin: CGPoint(), size: size)
        
        vc.isModalInPresentation = true
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .popover
        
        self.present(nav, animated: true) {
            // if you want to prevent toolbar buttons from being active
            // by setting passthroughViews to nil, you must do it after presentation is complete
            // I find this annoying; why does the toolbar default to being active?
            nav.popoverPresentationController?.passthroughViews = nil
        }
        
        if let pop = nav.popoverPresentationController {
            pop.sourceView = myLabel
            
            pop.delegate = self
            
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor:UIColor.black]
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    }


}
