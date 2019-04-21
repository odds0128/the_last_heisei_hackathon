//
//  Ex+UIView.swift
//  Topica
//
//  Created by yuki on 2019/04/20.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

@IBDesignable
class IEView: UIView {
    @IBInspectable var cornerRadius:CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    @IBInspectable var shadowColor: UIColor? {
        set { self.layer.shadowColor = newValue?.cgColor }
        get { return self.layer.shadowColor.map(UIColor.init) }
    }
    @IBInspectable var shadowOffset: CGSize {
        set { self.layer.shadowOffset = newValue }
        get { return self.layer.shadowOffset }
    }
    @IBInspectable var shadowRadius: CGFloat {
        set { self.layer.shadowRadius = newValue }
        get { return self.layer.shadowRadius }
    }
    @IBInspectable var shadowOpacity: Float {
        set { self.layer.shadowOpacity = newValue }
        get { return self.layer.shadowOpacity }
    }
    @IBInspectable var borderWidth: CGFloat {
        set { self.layer.borderWidth = newValue }
        get { return self.layer.borderWidth }
    }
    @IBInspectable var borderColor: UIColor? {
        set { self.layer.borderColor = newValue?.cgColor }
        get { return self.layer.borderColor.map(UIColor.init) }
    }
}

