//
//  DataGroupsArrayParam.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import Foundation
import RealmSwift


//MARK: - Data for groups


class RealmGroupsArrayParam: Object {
    @Persisted(primaryKey: true)
//    @Persisted
    var id: Int

    @Persisted
    var descriptionGroup: String?

    @Persisted
    var name: String

    @Persisted
    var photo100: String?
}
