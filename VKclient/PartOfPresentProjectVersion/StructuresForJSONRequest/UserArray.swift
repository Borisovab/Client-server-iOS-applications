//
//  UserArray.swift
//  VKclient
//
//  Created by Александр Борисов on 18.08.2022.
//

import Foundation

struct UserArray: Decodable {
    var response: [AboutUser]
}


struct AboutUser: Decodable {
    var id: Int
    var firstName: String
    var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
