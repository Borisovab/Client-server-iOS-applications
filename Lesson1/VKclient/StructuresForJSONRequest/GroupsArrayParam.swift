//
//  GroupsArrayParam.swift
//  VKclient
//
//  Created by Александр Борисов on 13.07.2022.
//

import Foundation

struct GroupsArrayParam: Decodable {

    let id: Int
    let description: String?
    let name: String
    let photo200: String?

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case name
        case photo200 = "photo_200"
    }

}
