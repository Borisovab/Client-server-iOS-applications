//
//  NetworkerProtocol.swift
//  VKclient
//
//  Created by Александр Борисов on 26.08.2022.
//

import Foundation

protocol NetworkerProtocol {
    func load<Model: Decodable> (
        request: URLRequest,
        completion: @escaping (Model?) -> Void
    )
}
