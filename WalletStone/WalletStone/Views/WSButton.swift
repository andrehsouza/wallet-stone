//
//  WSButton.swift
//  WalletStone
//
//  Created by Andre Souza on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

@IBDesignable
class WSButton: UIButton {

    @IBInspectable var fillColor: UIColor? = UIColor.white {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var shadowColor: UIColor? = UIColor.clear {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            if(isEnabled) {
                self.alpha = 1
            } else {
                self.alpha = 0.4
            }
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        setupButton()
    }
    
    func setupButton() {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        layer.masksToBounds = false
        self.layer.borderWidth = borderWidth
        self.layer.backgroundColor = fillColor?.cgColor
        
        //Shadow
        let shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = cornerRadius
        layer.shadowPath = shadowPath
        layer.shouldRasterize = true
        
        if(isEnabled) {
            self.alpha = 1
        } else {
            self.alpha = 0.4
        }
    }
    
    private func updateViewsFromIB() {
        #if !TARGET_INTERFACE_BUILDER
        // this code will run in the app itself
        #else
        // this code will execute only in IB
        self.setupButton()
        #endif
    }
}
