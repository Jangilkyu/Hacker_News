//
//  Constant.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/22.
//

import UIKit

let baseURL: String = "https://hacker-news.firebaseio.com/v0"

//EndPoint
enum ProjectURL: CustomStringConvertible {
    case topStories
    case getStory(itemNumber: Int)
    
    var description: String {
        switch self {
            case .topStories:
                return baseURL + "/topstories.json?print=pretty"
            case .getStory(let itemNumber):
                return baseURL + "/item/\(itemNumber).json?print=pretty"
        }
    }
}
