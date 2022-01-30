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
    
    var storyIDs: [Int] = []
    var restProcessor: RestProcessor!
    
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
        
        return collectionView
    }()
    
    func setConfigureCollectionView() {
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setConfigureRestProcessor() {
        restProcessor = RestProcessor()
        // restProcessor nil이 되면 메모리 해제됨
        restProcessor.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchTopStories()
    }
    
    func setup() {
        view.backgroundColor = .white
        addViews()
        setConstraints()
        setConfigureCollectionView()
        setConfigureRestProcessor()
    }
    
    func addViews() {
        view.addSubview(homeLabel)
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        homeLabelConstraints()
        collectionViewConstarints()
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
    
    func fetchTopStories() {
        restProcessor.fetchData(urlString: ProjectURL.topStories.description, usage: .topStories)
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
        return storyIDs.count
    }
    
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCellId,
            for: indexPath) as? MainCell else { return UICollectionViewCell() }
        
        cell.storyIDsLabel.text = "\(storyIDs[indexPath.item])"

        return cell
    }
            
            
    func collectionView(
        _ collecitonView: UICollectionView,
        layout collectionVIewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width - 15, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedItem = storyIDs[indexPath.item]
        print(selectedItem)
        
        let svc = StoryViewController(selectedItem, restProcessor)
        navigationController?.pushViewController(svc, animated: true)
    }

}

extension MainViewController: RestProcessorDelegate {
    func didSucessWith(data: Data, response: URLResponse, usage: ProjectURL) {
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
        
        switch usage {
            case .topStories:
                guard let decoded = try? JSONDecoder().decode([Int].self, from: data) else { return}
                self.storyIDs = decoded
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            default:
                break
        }
    }
    
    func didFailwith(error: Error?, response: URLResponse?, usage: ProjectURL) {
        
    }
    
    
}
