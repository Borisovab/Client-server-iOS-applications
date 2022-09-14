//
//  RealmStorage.swift
//  VKclient
//
//  Created by Александр Борисов on 26.08.2022.
//

import Foundation
import RealmSwift

class RealmStorage: DataStorageProtocol {
    private let realm = try? Realm()


    func save<Model: Object>(model: Model) {
        try? realm?.write({
            realm?.add(model, update: .all)
        })
    }

    func restore<Model: Object>() -> [Model] {
        guard let objects = realm?.objects(Model.self) else { return [] }
        return Array(objects)
    }


}
