//
//  Group.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import Foundation
import UIKit

struct Group {

    var avatar: String
    var name: String
    var description: String
    var photoGallery = [PhotosForFriendsGallery]()
    var id: Int
    var album = [UIImage]()
}
