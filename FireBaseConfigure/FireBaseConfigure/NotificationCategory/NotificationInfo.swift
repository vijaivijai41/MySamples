//
//  NotificationInfo.swift
//  FireBaseConfigure
//
//  Created by Vijay on 29/07/20.
//  Copyright © 2020 Fundsindia. All rights reserved.
//

import Foundation

enum MediaType: String,Codable {
    case image = "image"
    case video = "video"
    case audio = "audio"
    case gif = "gif"
    
    init?(value: String){
        switch value {
        case "image" : self = .image
        case "video" : self = .video
        case "gif" : self = .gif
        case "audio": self = .audio
        default : return nil
        }
    }
}

// MARK: - Welcome
struct NotificationInfo: Codable {
    let aps: Aps
    let mediaType: MediaType
    let attachmentURL: String

    enum CodingKeys: String, CodingKey {
        case aps, mediaType
        case attachmentURL = "attachment-url"
    }
}

// MARK: - Aps
struct Aps: Codable {
    let alert: Alert
    let mutableContent, category: String
    let redirection: String

    enum CodingKeys: String, CodingKey {
        case alert
        case mutableContent = "mutable-content"
        case category
        case redirection = "redirection-url"
    }
}

// MARK: - Alert
struct Alert: Codable {
    let title, body: String
}
