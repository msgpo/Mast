//
//  NewCaptionViewController.swift
//  mastodon
//
//  Created by Shihab Mehboob on 22/10/2018.
//  Copyright © 2018 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit
import StatusAlert

class NewCaptionViewController: UIViewController, UITextViewDelegate {
    
    var closeButton = MNGExpandedTouchAreaButton()
    var tootLabel = UIButton()
    var textView = UITextView()
    var keyHeight = 0
    var bgView = UIView()
    var titleV = UILabel()
    var editListName = ""
    var listID = ""
    var fromWhich = 0
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabHeight = Int(UITabBarController().tabBar.frame.size.height) + Int(34)
        var offset = 88
        var closeB = 47
        var botbot = 20
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2688:
                offset = 88
                closeB = 47
                botbot = 40
            case 2436, 1792:
                offset = 88
                closeB = 47
                botbot = 40
            default:
                offset = 64
                closeB = 24
                botbot = 20
                tabHeight = Int(UITabBarController().tabBar.frame.size.height)
            }
        }
        
        tootLabel.frame = CGRect(x: CGFloat(self.view.bounds.width - 175), y: CGFloat(closeB), width: CGFloat(150), height: CGFloat(36))
        if self.editListName == "" {
            tootLabel.setTitle("Add", for: .normal)
        } else {
            tootLabel.setTitle("Add", for: .normal)
        }
        tootLabel.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        tootLabel.setTitleColor(Colours.grayDark.withAlphaComponent(0.38), for: .normal)
        tootLabel.contentHorizontalAlignment = .right
        tootLabel.addTarget(self, action: #selector(didTouchUpInsideTootButton), for: .touchUpInside)
        self.view.addSubview(tootLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colours.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        var tabHeight = Int(UITabBarController().tabBar.frame.size.height) + Int(34)
        var offset = 88
        var closeB = 47
        var botbot = 20
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2688:
                offset = 88
                closeB = 47
                botbot = 40
            case 2436, 1792:
                offset = 88
                closeB = 47
                botbot = 40
            default:
                offset = 64
                closeB = 24
                botbot = 20
                tabHeight = Int(UITabBarController().tabBar.frame.size.height)
            }
        }
        
        
        bgView.frame = CGRect(x:0, y:Int(self.view.bounds.height) - 40 - Int(self.keyHeight), width:Int(self.view.bounds.width), height:Int(self.keyHeight) + 40)
        bgView.backgroundColor = Colours.tabSelected
        bgView.alpha = 0
        self.view.addSubview(bgView)
        
        self.closeButton = MNGExpandedTouchAreaButton(frame:(CGRect(x: 15, y: closeB, width: 32, height: 32)))
        self.closeButton.setImage(UIImage(named: "block")?.maskWithColor(color: Colours.grayLight2), for: .normal)
        self.closeButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.closeButton.adjustsImageWhenHighlighted = false
        self.closeButton.addTarget(self, action: #selector(didTouchUpInsideCloseButton), for: .touchUpInside)
        self.view.addSubview(self.closeButton)
        
        titleV.frame = CGRect(x: 24, y: offset + 6, width: Int(self.view.bounds.width), height: 30)
        if self.editListName == "" {
            titleV.text = "Media Caption".localized
        } else {
            titleV.text = "Media Caption".localized
        }
        titleV.textColor = Colours.grayDark2
        titleV.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        self.view.addSubview(titleV)
        
        textView.frame = CGRect(x:20, y: offset + 45, width:Int(self.view.bounds.width - 40), height:Int(self.view.bounds.height) - Int(170) - Int(self.keyHeight))
        textView.font = UIFont.systemFont(ofSize: Colours.fontSize1 + 2)
        textView.tintColor = Colours.tabSelected
        textView.delegate = self
        textView.becomeFirstResponder()
        if (UserDefaults.standard.object(forKey: "keyb") == nil) || (UserDefaults.standard.object(forKey: "keyb") as! Int == 0) {
            textView.keyboardType = .twitter
        } else {
            textView.keyboardType = .default
        }
        textView.keyboardAppearance = Colours.keyCol
        textView.backgroundColor = Colours.white
        textView.textColor = Colours.grayDark
        textView.text = self.editListName
        self.view.addSubview(textView)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.keyHeight = Int(keyboardHeight)
            self.updateTweetView()
        }
    }
    
    func updateTweetView() {
        var tabHeight = Int(UITabBarController().tabBar.frame.size.height) + Int(34)
        var offset = 88
        var closeB = 47
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2688:
                offset = 88
                closeB = 47
            case 2436, 1792:
                offset = 88
                closeB = 47
            default:
                offset = 64
                closeB = 24
                tabHeight = Int(UITabBarController().tabBar.frame.size.height)
            }
        }
        bgView.frame = CGRect(x:0, y:Int(self.view.bounds.height) - 50 - Int(self.keyHeight), width:Int(self.view.bounds.width), height:Int(self.keyHeight) + 50)
        textView.frame = CGRect(x:20, y:offset + 45, width:Int(self.view.bounds.width - 40), height:Int(self.view.bounds.height) - Int(offset) - Int(120) - Int(self.keyHeight))
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if (UserDefaults.standard.object(forKey: "hapticToggle") == nil) || (UserDefaults.standard.object(forKey: "hapticToggle") as! Int == 0) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            self.textView.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func didTouchUpInsideCloseButton(_ sender: AnyObject) {
        if (UserDefaults.standard.object(forKey: "hapticToggle") == nil) || (UserDefaults.standard.object(forKey: "hapticToggle") as! Int == 0) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        self.textView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if (UserDefaults.standard.object(forKey: "keyhap") == nil) || (UserDefaults.standard.object(forKey: "keyhap") as! Int == 0) {
            
        } else if (UserDefaults.standard.object(forKey: "keyhap") as! Int == 1) {
            let selection = UISelectionFeedbackGenerator()
            selection.selectionChanged()
        } else if (UserDefaults.standard.object(forKey: "keyhap") as! Int == 2) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        if (textView.text?.count)! > 0 {
            tootLabel.setTitleColor(Colours.tabSelected, for: .normal)
        } else {
            tootLabel.setTitleColor(Colours.grayDark.withAlphaComponent(0.38), for: .normal)
        }
    }
    
    
    @objc func didTouchUpInsideTootButton(_ sender: AnyObject) {
        if self.textView.text == "" { return }
        
        if (UserDefaults.standard.object(forKey: "hapticToggle") == nil) || (UserDefaults.standard.object(forKey: "hapticToggle") as! Int == 0) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        if self.fromWhich == 0 {
            StoreStruct.caption1 = self.textView.text ?? ""
        } else if self.fromWhich == 1 {
            StoreStruct.caption2 = self.textView.text ?? ""
        } else if self.fromWhich == 2 {
            StoreStruct.caption3 = self.textView.text ?? ""
        } else if self.fromWhich == 3 {
            StoreStruct.caption4 = self.textView.text ?? ""
        }
        
        self.textView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}




