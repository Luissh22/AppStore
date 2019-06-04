//
//  Extensions.swift
//  Instagram
//
//  Created by Luis Abraham on 2019-05-12.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        
        self.text = text
        self.font = font
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
        self.anchor(top: top, leading: nil, trailing: nil, bottom: nil, padding: .init(top: padding, left: 0, bottom: 0, right: 0))
    }
    
    func anchor(leading: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
        self.anchor(top: nil, leading: leading, trailing: nil, bottom: nil, padding: .init(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    func anchor(trailing: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
        self.anchor(top: nil, leading: nil, trailing: trailing, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: padding))
    }
    
    func anchor(bottom: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
        self.anchor(top: nil, leading: nil, trailing: nil, bottom: bottom, padding: .init(top: 0, left: 0, bottom: padding, right: 0))
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
    }
    
    func anchorCenter(x: NSLayoutXAxisAnchor) {
        self.anchorCenter(x: x, y: nil)
    }
    
    func anchorCenter(y: NSLayoutYAxisAnchor) {
        self.anchorCenter(x: nil, y: y)
    }
    
    func anchorCenter(x: NSLayoutXAxisAnchor?, y: NSLayoutYAxisAnchor?) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let x = x {
            self.centerXAnchor.constraint(equalTo: x).isActive = true
        }
        
        if let y = y {
            self.centerYAnchor.constraint(equalTo: y).isActive = true
        }
    }
    
    func anchorWidth(width: CGFloat) {
        self.anchorSize(size: .init(width: width, height: 0))
    }
    
    func anchorHeight(height: CGFloat) {
        self.anchorSize(size: .init(width: 0, height: height))
    }
    
    func anchorSize(width: CGFloat, height: CGFloat) {
        self.anchorSize(size: .init(width: width, height: height))
    }
    
    func anchorSize(size: CGSize = CGSize.zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewTopAnchor = self.superview?.topAnchor {
            self.topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = self.superview?.bottomAnchor {
            self.bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = self.superview?.leadingAnchor {
            self.leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = self.superview?.trailingAnchor {
            self.trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
}

