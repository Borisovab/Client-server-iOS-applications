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
    @Persisted
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
