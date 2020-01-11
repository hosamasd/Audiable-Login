//
//  PageCell.swift
//  Audiable Login
//
//  Created by hosam on 1/11/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page:PageModel! {
        didSet{
            mainImage.image = page.imageName
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), .foregroundColor: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes:[.font: UIFont.systemFont(ofSize: 14),.foregroundColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
            
        }
    }
    
    
    let mainImage:UIImageView = {
       let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
//        i.constrainWidth(constant: 250)
//        i.constrainHeight(constant: 350)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.isEditable = false
//        tv.textAlignment = .center
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.constrainHeight(constant: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        addSubViews(views: mainImage,textView,lineSeparatorView)
//        mainImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
//        mainImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
//        mainImage.centerXInSuperview()
        mainImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        lineSeparatorView.anchor(top: mainImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        textView.anchor(top: lineSeparatorView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 16, bottom: 0, right: 16))
      
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
    }
}
