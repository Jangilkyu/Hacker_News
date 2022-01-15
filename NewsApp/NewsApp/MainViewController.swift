//
//  MainViewController.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/15.
//

import Foundation
import UIKit

private let MainCellId = "MainCellId"

class MainViewController : UIViewController {
    let homeLabel: UILabel = {
        let homeLabel = UILabel()
        homeLabel.text = "Home"
        homeLabel.textAlignment = .center
        homeLabel.font = .systemFont(ofSize: 30)
        homeLabel.textColor = .black
        
        return homeLabel
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    func setConfigureCollectionView() {
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setConstraints()
    }
    
    func setup() {
        view.backgroundColor = .white
        addViews()
    }
    
    func addViews() {
        view.addSubview(homeLabel)
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        homeLabelConstraints()
        collectionViewConstarints()
        setConfigureCollectionView()
    }
    
    func homeLabelConstraints() {
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        homeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        homeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    func collectionViewConstarints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: homeLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

extension MainViewController :
        UICollectionViewDelegate,
        UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCellId,
            for: indexPath) as? MainCell else { return UICollectionViewCell() }
        return cell
    }
            
            
    func collectionView(
        _ collecitonView: UICollectionView,
        layout collectionVIewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

}
