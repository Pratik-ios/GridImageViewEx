//
//  ImagesApiStruct.swift
//  GrideImageViewEx
//
//  Created by Pratik on 09/11/21.
//

import Foundation

// MARK: - ImagesAPIResponseElement
struct ImagesAPIResponseElement: Codable {
    let date, explanation: String?
    let hdurl: String?
    let mediaType: MediaType?
    let serviceVersion: String?
    let title: String?
    let url: String?
    let copyright: String?

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url, copyright
    }
}

enum MediaType: String, Codable {
    case image = "image"
    case other = "other"
    case video = "video"
}

typealias ImagesAPIResponse = [ImagesAPIResponseElement]
