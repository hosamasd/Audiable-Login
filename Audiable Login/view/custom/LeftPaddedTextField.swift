//
//  LeftPaddedTextField.swift
//  Audiable Login
//
//  Created by hosam on 1/11/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class LeftPaddedTextField: UITextField {
    
    let padding:CGFloat
    let height:CGFloat
    
    init(padding:CGFloat,height:CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        self.layer.cornerRadius = height / 2
        backgroundColor = .white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: height)
        
    }
    
}

