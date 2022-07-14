//
//  FriendsJSONInfo.swift
//  VKclient
//
//  Created by Александр Борисов on 13.07.2022.
//

import Foundation

struct FriendsJSONInfo<Response: Decodable>: Decodable {
    let response: Response
}


struct ResponseFriends: Decodable {
    let count: Int
    let items: [FriendsArrayParam]

}


struct ResponseGroups: Decodable {
    let count: Int
    let items: [GroupsArrayParam]
}


struct ResponsePhotos: Decodable {
    let count: Int
    let items: [PhotosArrayParam]
}
