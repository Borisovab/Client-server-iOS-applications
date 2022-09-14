//
//  Session.swift
//  VKclient
//
//  Created by Александр Борисов on 06.07.2022.
//

import Foundation

class Session {

    static let sharedInstance = Session()

    private init() {}

    var token = ""
    var userId = 777

    var userParam = (id:"", firstName:"", lastName:"")

    var Id = 0
    var friendsIDArray = [Int]()

}
