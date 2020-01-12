//
//  LoginCell.swift
//  Audiable Login
//
//  Created by hosam on 1/11/20.
//  Copyright © 2020 hosam. All rights reserved.
//


import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
//        imageView.constrainHeight(constant: 120)
//        imageView.constrainWidth(constant: 120)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField(padding: 16, height: 50)
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField(padding: 16, height: 50)
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.constrainHeight(constant: 50)
        return button
    }()
    lazy var mainStack:UIStackView = {
       let s = getStack(views:logoImageView,emailTextField,passwordTextField,loginButton , spacing: 8, distribution: .fill, axis: .vertical)
        
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews(views: mainStack)
        mainStack.centerInSuperview(size: .init(width: frame.width - 32, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








