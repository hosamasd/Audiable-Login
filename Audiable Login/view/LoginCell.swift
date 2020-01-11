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
        imageView.constrainHeight(constant: 160)
        imageView.constrainWidth(constant: 120)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews(views: logoImageView,emailTextField,passwordTextField,loginButton)
        
        logoImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        logoImageView.centerXInSuperview()
        
        emailTextField.anchor(top: logoImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








