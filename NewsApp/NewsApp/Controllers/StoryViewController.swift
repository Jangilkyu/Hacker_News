//
//  StoryViewController.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/29.
//

import Foundation
import UIKit


class StoryViewController: UIViewController {
    
    var storyId: Int!
    var restProcessor: RestProcessor!
    
    convenience init(_ storyId: Int,
                     _ restProcessor: RestProcessor) {
        self.init()
        self.storyId = storyId
        self.restProcessor = restProcessor
        
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
    
    func setup() {
        self.restProcessor.delegate = self
        self.restProcessor.fetchData(urlString: ProjectURL.getStory(itemNumber: storyId).description, usage: .getStory(itemNumber: storyId))
    }
}

extension StoryViewController: RestProcessorDelegate {
    func didSucessWith(
        data: Data,
        response: URLResponse,
        usage: ProjectURL) {
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            
            switch usage {
                case .getStory:
                    guard let decoded = try? JSONDecoder().decode(Story.self, from: data) else { return }
                
            default:
                break
                
            }
        
    }
    
    func didFailwith(
        error: Error?,
        response: URLResponse?,
        usage: ProjectURL) {
        
    }
    
    
}
