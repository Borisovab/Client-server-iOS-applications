//
//  JsonPhoto.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import Foundation




struct JsonPhotoArray: Decodable {
    let ownerId: Int
    let sizes: [GetSizePhoto]

    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes
    }
}


struct GetSizePhoto: Decodable {
    let url: String?
}
