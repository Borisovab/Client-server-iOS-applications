//
//  URLSessionNetworker.swift
//  VKclient
//
//  Created by Александр Борисов on 11.07.2022.
//

import Foundation

class URLSessionNetworker {

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    private let urlSession: URLSession
}
