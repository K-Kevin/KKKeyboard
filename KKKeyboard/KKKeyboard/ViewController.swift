//
//  ViewController.swift
//  KKKeyboard
//
//  Created by likai on 2017/6/26.
//  Copyright © 2017年 likai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var speakLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(tappedView))
        speakLbl.addGestureRecognizer(tapRec)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyboardShown), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyboardShown), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyboardHidden), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedView() {
        self.view.addSubview(self.coverView)
        self.view.addSubview(self.commentView)
        self.commentView.textView.becomeFirstResponder()
    }
    
    func tappedCoverView() {
        self.view.endEditing(true)
    }
    
    
    func willKeyboardShown(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        
        if userInfo == nil {
            return
        }
        
        let keyboardHeight = notification.keyboardSize().height
        let duration = notification.duration()
        let curve = notification.curve()

        if keyboardHeight <= 0 {
            return
        }
        
        let lastTransform = self.commentView.transform
        self.commentView.transform = .identity

        self.commentView.transform = lastTransform // Restore transform
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: Int(curve))!)
        UIView.setAnimationDuration(duration)
        
        self.coverView.alpha = 1
        self.commentView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight-140)
        
        UIView.commitAnimations()
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        
        if userInfo == nil {
            return
        }
        
        let duration = notification.duration()
        let curve = notification.curve()
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: Int(curve))!)
        UIView.setAnimationDuration(duration)
        
        self.coverView.alpha = 0
        self.commentView.transform = .identity
        
        UIView.setAnimationDidStop(#selector(afterAnimationStops))
        UIView.commitAnimations()
    }

    func afterAnimationStops()  {
        self.commentView.removeFromSuperview()
        self.coverView.removeFromSuperview()
    }
    
    fileprivate lazy var commentView : CommentView = {
        let view = Bundle.main.loadNibNamed("CommentView", owner: nil, options: nil)?.first as! CommentView
        view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 140)
        return view
    }()
    
    fileprivate lazy var coverView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.3)
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(tappedCoverView))
        view.addGestureRecognizer(tapRec)
        return view
    }()
    
}
