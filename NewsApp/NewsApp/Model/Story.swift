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
    let by: String
    let time: Int
    let url: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case type = "type"
        case by = "by"
        case time = "time"
        case url = "url"
        case text = "text"
    }
}
