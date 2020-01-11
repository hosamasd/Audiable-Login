//
//  ViewController.swift
//  Audiable Login
//
//  Created by hosam on 1/11/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let cellId = "cellId"
    fileprivate let loginCellId = "loginCellId"
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
    let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.isPagingEnabled = true
        c.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        c.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        c.backgroundColor = .white
        return c
    }()
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(r: 247, g: 154, b: 27), for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        button.constrainWidth(constant: 60)
        button.constrainHeight(constant: 50)
        return button
    }()
    
     lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(r: 247, g: 154, b: 27), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.constrainWidth(constant: 60)
        button.constrainHeight(constant: 50)
        return button
    }()
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(r: 247, g: 154, b: 27)
        pc.numberOfPages = self.pagees.count + 1
        pc.constrainHeight(constant: 40)
        return pc
    }()
    let pagees:[PageModel] = {
        let pages =   [   PageModel(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipient's first book is on us.", imageName: #imageLiteral(resourceName: "page1")),
   PageModel(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: #imageLiteral(resourceName: "page3")),
   PageModel(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: #imageLiteral(resourceName: "page2"))
        ]
    return pages
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        
    }


    func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubViews(views: collectionView,nextButton,skipButton,pageControl)
        
        
        nextButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        skipButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        pageControl.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
//        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
//
//        skipButtonTopAnchor = skipButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
//
//        nextButtonTopAnchor = nextButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
//
//        //use autolayout instead
//        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
         collectionView.fillSuperview()
    }
    
    
    
   @objc func handleNext()  {
        print(987)
    }
    
    @objc func handleSkip()  {
        print(987)
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pagees.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pagees.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        let pg = pagees[indexPath.item]
        
        cell.page = pg
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    
    
}
