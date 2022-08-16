//
//  PhotosArrayParam.swift
//  VKclient
//
//  Created by Александр Борисов on 13.07.2022.
//

import Foundation

struct PhotosArrayParam: Decodable {

    let albumId: Int
    let id: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case id
        case sizes
    }
}


struct Size: Decodable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}
