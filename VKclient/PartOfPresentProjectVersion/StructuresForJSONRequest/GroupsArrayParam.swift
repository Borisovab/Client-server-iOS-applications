//
//  GroupsArrayParam.swift
//  VKclient
//
//  Created by Александр Борисов on 13.07.2022.
//

import Foundation

struct GroupsArrayParam: Decodable {

    let id: Int
    let descriptionGroup: String?
    let name: String
    let photo100: String?

    enum CodingKeys: String, CodingKey {
        case id
        case descriptionGroup = "description"
        case name
        case photo100 = "photo_100"
    }

}
