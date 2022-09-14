//
//  FriendsDataBase.swift
//  VKclient
//
//  Created by Александр Борисов on 18.08.2022.
//

import Foundation
import FirebaseFirestore


struct FBGroup: Codable {
    let id: Int
    let name: String
}


struct FBUser: Codable {
    let id: Int
    var groups: [FBGroup]
}



extension FBUser {

    static func mock(array:[RealmGroupsArrayParam], id: Int ) -> FBUser {

        var groups = [FBGroup]()

        array.forEach{ groups.append(FBGroup(id: $0.id, name: $0.name))}

        return FBUser(id: id, groups: groups)
    }
}

/*
Как я себе представляю иерархию, в формате json:
[
"user": {
    "id": Int,
    "group": [
        {
            "id": Int
            "name": String
        }
    ]
    }
]
*/
