//
//  FriendsPostViewModel.swift
//  VKclient
//
//  Created by Александр Борисов on 26.08.2022.
//

import Foundation


struct FriendsPostViewModel {
    let avatar: String
    let firstName: String
    let lastName: String
}

extension FriendsPostViewModel {
    init(from netData: FriendsArrayParam) {
        avatar = netData.avatar
        firstName = netData.firstName
        lastName = netData.lastName
    }

    init(from dataBase: RealmFriendsArrayParam) {
        avatar = dataBase.avatar
        firstName = dataBase.firstName
        lastName = dataBase.lastName
    }
}
