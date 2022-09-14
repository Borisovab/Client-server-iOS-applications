//
//  NetworkController.swift
//  VKclient
//
//  Created by Александр Борисов on 26.08.2022.
//

import Foundation


class NetworkController: NetworkerProtocol {
    func load<Model: Decodable> (
        request: URLRequest,
        completion: @escaping (Model?) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
                let data = data ?? Data()
                let model: Model? = self?.parse(data: data)
                completion(model)
        }.resume()
    }
    

    private func parse<Model: Decodable>(data: Data) -> Model? {
        return try? JSONDecoder().decode(Model.self, from: data)
    }
}
