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
        
        self.navigationItem.title = "Hacker News"
        self.navigationController?.navigationBar.backgroundColor = .red
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
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionViewConstarints()
    }
    
    func collectionViewConstarints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
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
        
        restProcessor.fetchSingleItem(urlString: ProjectURL.getStory(itemNumber: storyIDs[indexPath.item]).description) { result in
            guard let data = try? result.get() else { return }
            guard let decoded = try? JSONDecoder().decode(Story.self, from: data) else { return }
//            print(self.)
            
            DispatchQueue.main.async {
                cell.storyIDsLabel.text = decoded.title
                cell.authorByLabel.text = "by \(decoded.by)"
                cell.timeLabel.text = "\(self.IntToDate(decoded.time))"
            }
        }

        return cell
    }
    
    func IntToDate(_ time: Int) -> String {
        let timeInterval = TimeInterval(time)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        dateFormatter.locale = Locale.current
        let convertStr = dateFormatter.string(from: myNSDate)
        
        return convertStr
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
