//
//  GroupsPostViewModel.swift
//  VKclient
//
//  Created by Александр Борисов on 14.09.2022.
//

import Foundation

struct GroupsPostViewModel {
    let avatar: String
    let name: String
}

extension GroupsPostViewModel {
    init(from netData: GroupsArrayParam) {
        avatar = netData.photo100 ?? ""
        name = netData.name
    }

    init(from dataBase: RealmGroupsArrayParam) {
        avatar = dataBase.photo100 ?? ""
        name = dataBase.name
    }
}
