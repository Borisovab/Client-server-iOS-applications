//
//  DataStorageProtocol.swift
//  VKclient
//
//  Created by Александр Борисов on 26.08.2022.
//

import Foundation
import SwiftUI
import RealmSwift

protocol DataStorageProtocol {
    func save<Model: Object>(model: Model)

    func restore<Model: Object>() -> [Model]
}
