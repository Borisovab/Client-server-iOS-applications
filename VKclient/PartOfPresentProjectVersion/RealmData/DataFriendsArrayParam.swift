//
//  DataFriendsArrayParam.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import Foundation
import RealmSwift

//MARK: - Data for friends


class RealmFriendsArrayParam: Object {
    @Persisted(primaryKey: true)
//    @Persisted
    var id: Int

    @Persisted
    var avatar: String

    @Persisted
    var trackCode: String

    @Persisted
    var firstName: String

    @Persisted
    var lastName: String

    @Persisted
    var canAccessClosed: Bool?

    @Persisted
    var isClosed: Bool?
}


extension RealmFriendsArrayParam {
    func fillData(with model: FriendsArrayParam) {
        id = model.id
        avatar = model.avatar
        trackCode = model.trackCode
        firstName = model.firstName
        lastName = model.lastName
        canAccessClosed = model.canAccessClosed
        isClosed = model.isClosed
    }
}
