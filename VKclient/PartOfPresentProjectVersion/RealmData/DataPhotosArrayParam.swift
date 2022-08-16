//
//  DataPhotosArrayParam.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import Foundation
import RealmSwift

//MARK: - Data for photo

class RealmResponsePhotos: Object {
    @Persisted
    var count: Int

    @Persisted
    var items: List<RealmPhotosArrayParam>

}


class RealmPhotosArrayParam: Object {
    @Persisted
    var albumId: Int

    @Persisted
    var id: Int

    @Persisted
    var sizes: List<SizesPhotos>
}


class SizesPhotos: Object {
    @Persisted
    var height: Int?

    @Persisted
    var url: String?

    @Persisted
    var type: String?

    @Persisted
    var width: Int?
}
