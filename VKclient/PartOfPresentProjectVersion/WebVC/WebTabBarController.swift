//
//  WebTabBarController.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import UIKit

class WebTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
    }
}
