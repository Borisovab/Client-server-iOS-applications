//
//  Storage.swift
//  VKclient
//
//  Created by Александр Борисов on 17.06.2022.
//

import UIKit

class Storage: NSObject {

    static let shared = Storage()

    private override init() {
        super.init()
    }

    var peopleForSelect = ModelPeople()
    var friends = [Human]()
    var myData = ModelMyProfile()
    var groups = ModelGroup()
}

