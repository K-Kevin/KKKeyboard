//
//  CommentView.swift
//  KKKeyboard
//
//  Created by likai on 2017/6/26.
//  Copyright © 2017年 likai. All rights reserved.
//

import UIKit

class CommentView: UIView {

    var sendClickAction: (() -> ())?

    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.layer.cornerRadius = 2
            textView.layer.borderWidth = 0.5
            textView.layer.borderColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1).cgColor
        }
    }
    

    @IBAction func sendClick(_ sender: Any) {
        sendClickAction?()
    }
    
}
