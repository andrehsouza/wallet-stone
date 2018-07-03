//
//  WSCardView.swift
//  WalletStone
//
//  Created by Andre Souza on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

@IBDesignable
class WSCardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2 {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var shadowColor: UIColor? = UIColor.black {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var layerBackgroundColor: UIColor? = UIColor.clear {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    @IBInspectable var borderColor: UIColor? = UIColor.white {
        didSet {
            self.updateViewsFromIB()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupCard()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupCard()
    }
    
    func setupCard() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor?.cgColor
        layer.masksToBounds = false
        layer.borderWidth = borderWidth
        layer.backgroundColor = self.layerBackgroundColor?.cgColor
        //Shadow
        let shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = cornerRadius
        layer.shadowPath = shadowPath
        layer.shouldRasterize = true
    }
    
    private func updateViewsFromIB() {
        #if !TARGET_INTERFACE_BUILDER
        // this code will run in the app itself
        #else
        // this code will execute only in IB
        self.setupCard()
        #endif
    }
}
