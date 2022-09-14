//
//  GroupsGateway.swift
//  VKclient
//
//  Created by Александр Борисов on 14.09.2022.
//

import Foundation
import RealmSwift

class GroupsGateway {
    init(
        network: NetworkController,
        dataBase: RealmStorage
    ) {
        self.network = network
        self.dataBase = dataBase
    }

    let network: NetworkerProtocol
    let dataBase: DataStorageProtocol

    func loadPosts(completion: @escaping([GroupsPostViewModel]) -> Void) {
        var components = URLComponents(string: "https://api.vk.com/method/groups.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard
            let url = components?.url
        else {
            completion([])
            return
        }

        let request = URLRequest(url: url)
        network.load(request: request) { [weak self] (model: JSONInfo<ResponseGroups>?) in

            if let model = model {
                DispatchQueue.main.async {
                    model.response.items
                        .map { netPost in
                            let post = RealmGroupsArrayParam()
                            post.fillData(with: netPost)
                            return post
                        }
                        .forEach { self?.dataBase.save(model: $0) }

                    let viewData = model.response.items
                        .map { GroupsPostViewModel(from: $0) }

                    completion(viewData)
                }
            } else {
                DispatchQueue.main.async {
                    let values: [RealmGroupsArrayParam]? = self?.dataBase.restore()
                    let viewData = (values ?? [])
                        .map { GroupsPostViewModel(from: $0) }

                    completion(viewData)
                }
            }
        }
    }
}
