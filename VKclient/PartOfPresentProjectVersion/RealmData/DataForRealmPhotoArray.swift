//
//  DataForRealmPhotoArray.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import Foundation
import RealmSwift

class RealmPhotosArray: Object {
    @Persisted
    var ownerId: Int

    @Persisted
    var sizes: List<DataSizePhoto>
}


class DataSizePhoto: Object {
    @Persisted
    var url: String?

}
