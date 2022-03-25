//
//  DesclimerView.swift
//  ImageUpload
//
//  Created by Vijay on 29/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class DesclimerView: UIView {
  
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var textViewHeightConstrains: NSLayoutConstraint!
    
    static func loadView()-> DesclimerView? {
        let view = Bundle(for: DesclimerView.self).loadNibNamed(String(describing: DesclimerView.self), owner: nil, options: nil)![0] as? DesclimerView
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
}



