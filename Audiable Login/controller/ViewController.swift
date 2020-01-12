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
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeKeyboardNotifications()
    }

    
    
        

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
        let index = pageControl.currentPage
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let number = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = number
        if number == pagees.count{
            handleHideElements()
            
        }else {
            handleShowElements()
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func handleHideElements()  {
        pageControlBottomAnchor?.constant = 80
        skipButtonTopAnchor?.constant = -80
        nextButtonTopAnchor?.constant = -80
    }
    
    func handleShowElements()  {
        pageControlBottomAnchor?.constant = 0
        skipButtonTopAnchor?.constant = 0
        nextButtonTopAnchor?.constant = 0
    }
    
    func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubViews(views: collectionView,nextButton,skipButton,pageControl)
        
        
        nextButton.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        skipButton.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        pageControl.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        pageControlBottomAnchor?.isActive = true
        
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        skipButtonTopAnchor?.isActive = true
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        nextButtonTopAnchor?.isActive = true
        collectionView.fillSuperview()
    }
    
    @objc func keyboardHide() {
        view.endEditing(true)
        animateView()
    }
    
    fileprivate func animateView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc func keyboardShow(notify:Notification) {
        guard let value = notify.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        //
        if let cell = collectionView.cellForItem(at: IndexPath(item: pagees.count, section: 0)) as? LoginCell {
            let mainStack = cell.mainStack
            
        let bottomSpace = view.frame.height - mainStack.frame.origin.y - mainStack.frame.height
        let difference = keyboardFrame.height - bottomSpace
        view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        }
    }
    
    @objc func handleNext()  {
        let nextIndex = min(pageControl.currentPage + 1, pagees.count+1 )
        
        nextIndex == 3 ? handleHideElements() : handleShowElements()
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    @objc func handleSkip()  {
        let index = pagees.count
        handleHideElements()
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
