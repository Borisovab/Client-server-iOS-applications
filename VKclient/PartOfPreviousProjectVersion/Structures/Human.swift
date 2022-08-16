//
//  Human.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import Foundation

struct PhotosForFriendsGallery {
    var url: String
    var isLiked = false
    var likeCounter = 0
}

struct Human {

    var avatar: String
    var name: String
    var city: String
    var photoGallery = [PhotosForFriendsGallery]()
    var id: Int

}

