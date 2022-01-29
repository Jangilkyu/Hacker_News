//
//  Story.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/29.
//

import Foundation

struct Story: Codable {
    let title: String
    let type: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case type = "type"
        case url = "url"
    }
}
