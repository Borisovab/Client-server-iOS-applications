//
//  DataUserArray.swift
//  VKclient
//
//  Created by Александр Борисов on 18.08.2022.
//

import Foundation
import RealmSwift

class DataAboutUser: Object {
    @Persisted(primaryKey: true)
//    @Persisted
    var id: Int

    @Persisted
    var firstName: String

    @Persisted
    var lastName: String
}
