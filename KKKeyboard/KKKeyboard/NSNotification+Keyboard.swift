//
//  NSNotification+Keyboard.swift
//  KKKeyboard
//
//  Created by likai on 2017/6/26.
//  Copyright © 2017年 likai. All rights reserved.
//

import UIKit
import Foundation

extension NSNotification {
    
    func keyboardSize() -> CGSize {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardFrameEndUserInfoKey]!.cgRectValue.size
        }
        return CGSize.zero
    }
    
    func keyboardFrame() -> CGRect {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardFrameEndUserInfoKey]!.cgRectValue
        }
        return CGRect.zero
    }
    
    func duration() -> Double {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        }
        return 0.0
    }
    
    func curve() -> Double {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardAnimationCurveUserInfoKey]!.doubleValue
        }
        return 0.0
    }
}
