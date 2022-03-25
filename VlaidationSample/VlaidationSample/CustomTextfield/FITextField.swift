//
//  FITextField.swift
//  TheameConfiguration
//
//  Created by Vijay on 10/07/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

public extension String {
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}

@IBDesignable public class FITextField: UITextField {

    /// Title label color
    @IBInspectable var titleLabelColor: UIColor = UIColor.gray {
        didSet {
            self.titleLabel.textColor = titleLabelColor
            setNeedsDisplay()
        }
    }
    
    /// PlaceHoledr Color
    @IBInspectable var placeholderColor: UIColor = UIColor.gray {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                       attributes: [NSAttributedString.Key.foregroundColor:placeholderColor])
            setNeedsDisplay()
        }
    }
    
    /// ErrorLabeColor
    @IBInspectable var errorLabelColor: UIColor = UIColor.red {
        didSet {
            self.errorLabel.textColor = errorLabelColor
            self.layerError.backgroundColor = errorLabelColor.cgColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var typeTextField: Int = FITextField.TiteleStatus.beginEdit.rawValue {
        didSet {
            titleShowStatus = FITextField.TiteleStatus(rawValue: typeTextField) ?? TiteleStatus.beginEdit
        }
    }
   
   
    public var borderColor: UIColor = UIColor.gray {
        didSet {
            layerError.backgroundColor = borderColor.cgColor
        }
    }
    
    
    /// label status
    ///
    /// - none: never shown
    /// - beginEdit: edit begin show
    /// - always: always show title
    public enum TiteleStatus: Int {
        case none
        case beginEdit
        case always
    }
    
    public enum borderStatus {
        case errorOnly
        case always
    }
    
    fileprivate var titleLabel: UILabel = UILabel()
    fileprivate var errorLabel: UILabel = UILabel()
    fileprivate var layerError: CALayer = CALayer()
    
    public var titleShowStatus: TiteleStatus = .none
    public var borderShowStatus: borderStatus = .always
    
    fileprivate var animateFloatPlaceholder:Bool = true
    fileprivate var hideErrorWhenEditing:Bool   = true
    
    /// Initialize View
    ///
    /// - Parameter frame: Frame as per view
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /// Initialize coder
    ///
    /// - Parameter aDecoder: coder and decoder views
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /// Initialize for Default
    fileprivate func initialize() {
        self.titleLabel.frame = CGRect.zero
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.alpha = 0.0
        self.addSubview(self.titleLabel)
        
        self.errorLabel.frame = CGRect.zero
        self.errorLabel.isHidden = true
        self.errorLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.errorLabel)
        
        self.layerError.frame = CGRect.zero
        self.layerError.isHidden = true
        layer.addSublayer(self.layerError)
        layer.insertSublayer(self.layerError, at: 0)

        titleShowStatus = .always
        borderShowStatus = .errorOnly
        addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
        addTarget(self, action: #selector(beginEdit), for: .editingDidBegin)

    }
    
    @objc func beginEdit() {
        errorMsg = ""
        guard hideErrorWhenEditing && (errorMsg.isEmpty) else { return }
    }
    
    public func showError(message:String? = nil) {
        guard let mes = message  else {
            self.layerError.backgroundColor = borderColor.cgColor
            hideError()
            errorMsg = ""
            return
        }
        errorMsg = mes

    }
    
    /// Error Message wise show error values
    public var errorMsg: String = "" {
        didSet{
            //guard errorMsg != oldValue else { return }
            self.errorLabel.text = errorMsg
            guard !errorMsg.isEmptyStr else {
                
                hideError()
                return
            }
            
            guard !errorMsg.isEmptyStr else { return }
            
            showError()
        }
    }
    
    /// Text field begin edit
    @objc fileprivate func textFieldTextChanged() {
        errorMsg = ""
        guard hideErrorWhenEditing && (errorMsg.isEmpty) else { return }
        
    }
    
    /// If am add left view its show on x
    fileprivate var x: CGFloat {
        if let leftView = leftView {
            return leftView.frame.origin.x + leftView.bounds.size.width - leftPadding
        }
        
        return leftPadding
    }
    
    /// Height of font
    fileprivate var fontHeight: CGFloat {
        return ceil(font!.lineHeight)
    }
    
    fileprivate var leftPadding:CGFloat = 5.0
    fileprivate var topPadding: CGFloat = 10
    
    fileprivate var titleLabelYAxis: CGFloat = 3.0 {
        didSet{ invalidateIntrinsicContentSize() }
    }
    
    fileprivate var errorLabelYAxis: CGFloat = 3.0 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    public override var text: String? {
        didSet { textFieldTextChanged()}
    }
    
    /// if constrins changes to update values
    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()

        let textFieldIntrinsicContentSize = super.intrinsicContentSize
        
       if !errorMsg.isEmpty {
            titleLabel.sizeToFit()
            return CGSize(width: textFieldIntrinsicContentSize.width,
                          height: textFieldIntrinsicContentSize.height + titleLabelYAxis + errorLabelYAxis + titleLabel.bounds.size.height + errorLabel.bounds.size.height + topPadding)
        }else {
            return CGSize(width: textFieldIntrinsicContentSize.width,
                          height: textFieldIntrinsicContentSize.height + titleLabelYAxis + titleLabel.bounds.size.height + topPadding)
        }
    }
    
    
    /// Change layout affect values
    override public func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .transitionFlipFromRight, animations: {
            if self.borderShowStatus == .always {
                self.layerError.isHidden = false
                self.layerError.backgroundColor = self.borderColor.cgColor
                self.layerError.frame = CGRect(x: self.leftPadding, y: self.bounds.size.height - 1, width: self.bounds.size.width, height: 1)
            } else {
                self.layerError.isHidden = false
                self.layerError.frame = CGRect.zero
            }
            if !self.errorMsg.isEmptyStr {
                var lblFrame = self.errorLabel.frame
                self.errorLabel.isHidden = false
                self.layerError.backgroundColor = self.errorLabelColor.cgColor
                lblFrame.origin.y = self.bounds.size.height - self.errorLabel.frame.size.height
                self.errorLabel.frame = lblFrame
                self.layerError.frame = CGRect(x: self.leftPadding, y: (self.bounds.size.height -  self.errorLabel.frame.size.height)-1, width: self.bounds.size.width, height: 1)
            } else {
                self.errorLabel.isHidden = true
                self.errorLabel.frame = CGRect.zero
            }
            
            let titleLabelSize = self.titleLabel.sizeThatFits(self.titleLabel.superview!.bounds.size)
            self.titleLabel.frame = CGRect(x: self.x, y: self.titleLabel.frame.origin.y,
                                      width: titleLabelSize.width,
                                      height: titleLabelSize.height)
            
        }, completion: nil)
        
        switch titleShowStatus {
        case .always:
            self.titleLabel.text = placeholder
            showTitelLabel(isFirstResponder)
        case .beginEdit:
            if let enteredText = text,!enteredText.isEmptyStr{
                showTitelLabel(isFirstResponder)
            }else{
                hideTitleLabel(isFirstResponder)
            }
        case .none:
            hideTitleLabel(isFirstResponder)
        }
        
    }
    
    /// Show Title status
    ///
    /// - Parameter animated: is Animated
    fileprivate func showTitelLabel(_ animated:Bool) {
        let animations:(()->()) = {
            if let placeholderText = self.placeholder {
                self.titleLabel.text = placeholderText

            }
            self.titleLabel.sizeToFit()
            self.invalidateIntrinsicContentSize()
            
            self.titleLabel.alpha = 1.0
            self.titleLabel.frame = CGRect(x: self.leftPadding,
                                                    y: self.titleLabelYAxis,
                                                    width: self.titleLabel.bounds.size.width,
                                                    height: self.titleLabel.bounds.size.height)
        }
        
        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: [.beginFromCurrentState,.curveEaseOut],
                           animations: animations){ status in
                            DispatchQueue.main.async {
                                self.layoutIfNeeded()
                            }
            }
        }else{
            animations()
        }
    }
    
    /// Hide Title Label animations
    ///
    /// - Parameter animated: animated
    fileprivate func hideTitleLabel(_ animated:Bool) {
        let animations:(()->()) = {
            self.titleLabel.alpha = 0.0
            self.titleLabel.frame = CGRect(x: self.leftPadding,
                                                    y: self.titleLabel.font.lineHeight,
                                                    width: self.titleLabel.bounds.size.width,
                                                    height: self.titleLabel.bounds.size.height)
        }
        
        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: [.beginFromCurrentState,.curveEaseOut],
                           animations: animations){ status in
                            DispatchQueue.main.async {
                                self.layoutIfNeeded()
                            }
            }
        }else{
            animations()
        }
    }
    
    /// Error Show with check error messag
    fileprivate func showError()  {
        self.errorLabel.sizeToFit()
        self.errorLabel.frame = CGRect(x: leftPadding, y: self.bounds.size.height - self.errorLabel.frame.size.height, width: self.bounds.size.width, height: self.errorLabel.frame.size.height + 5)
        self.invalidateIntrinsicContentSize()

    }
    
    /// Error Hide border View
    func hideError() {
        self.errorLabel.isHidden = true
        self.errorLabel.frame = CGRect.zero
    }
    
    
    /// Rect for empty textfield
    ///
    /// - Parameter rect: rect value
    /// - Returns: cgrect
    fileprivate func insetRectForEmptyBounds(rect:CGRect) -> CGRect {
        let newX = x
        guard (!errorMsg.isEmpty) else { return CGRect(x: newX, y: 0, width: rect.width - newX - leftPadding, height: rect.height) }
        
        let topInset = (rect.size.height - errorLabel.bounds.size.height - errorLabelYAxis - fontHeight) / 2.0
        let textY = topInset - ((rect.height - fontHeight) / 2.0)

        return CGRect(x: newX, y: floor(textY), width: rect.size.width - newX - leftPadding, height: rect.size.height)
    }
   
    /// Rect for empty textfield
    ///
    /// - Parameter rect: rect value
    /// - Returns: cgrect
    fileprivate func insetRectForBounds(rect:CGRect) -> CGRect {
        if titleShowStatus == .none {
            return insetRectForEmptyBounds(rect: rect)
        }else{
            
            if let text = text,text.isEmptyStr && titleShowStatus == .beginEdit {
                return insetRectForEmptyBounds(rect: rect)
            }else{
                let topInset = titleLabelYAxis + titleLabel.bounds.size.height + (topPadding / 2.0)
                let textOriginalY = (rect.height - fontHeight) / 2.0
                var textY = topInset - textOriginalY
                
                if textY < 0 && (errorMsg.isEmpty) { textY = topInset }
                let newX = x
                return CGRect(x: newX, y: ceil(textY), width: rect.size.width - newX - leftPadding, height: rect.height)
            }
        }
    }
    
    
    // Textfield atributes
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
        
    }
}
