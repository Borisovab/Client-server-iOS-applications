//
//  PostViewModel.swift
//  VKclient
//
//  Created by Александр Борисов on 16.08.2022.
//

import Foundation


struct FriendsModel {
    let avatar: String
    let firstName: String
    let lastName: String
}


struct GroupModel {
    let id: Int
    let name: String
    let photo100: String?
}


struct PhotoNodel {
    let url: String?
}
