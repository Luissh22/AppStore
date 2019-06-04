//
//  VerticalStackView.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-20.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach(addArrangedSubview(_:))
        
        self.axis = .vertical
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
