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
    var Id = 0

}
