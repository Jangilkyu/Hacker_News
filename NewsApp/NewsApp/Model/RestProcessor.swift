//
//  RestProcessor.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/22.
//

import UIKit

protocol RestProcessorDelegate: AnyObject {
    func didSucessWith(data: Data, response: URLResponse, usage: ProjectURL)
    func didFailwith(error: Error?, response: URLResponse?, usage: ProjectURL)
}

class RestProcessor {
    
    weak var delegate: RestProcessorDelegate?

    
    func fetchData(urlString: String, usage: ProjectURL) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {
            data, response, error in
            
            guard error == nil,
                let httpResponse = (response as? HTTPURLResponse),
                httpResponse.statusCode == 200,
                
                    let data = data else {
                        self.delegate?.didFailwith(error: error, response: response, usage: usage)
                        
                        return
                    }
            
            self.delegate?.didSucessWith(data: data, response: httpResponse, usage: usage)
            
//                self.storyIDs = decoded
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
        }
        
        dataTask.resume()
    }
    
}
