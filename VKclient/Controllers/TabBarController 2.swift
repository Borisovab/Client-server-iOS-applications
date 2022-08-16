//
//  TabBarController.swift
//  VKclient
//
//  Created by Александр Борисов on 15.06.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.navigationBar
//            .isTranslucent = false
//        self.navigationController?.navigationBar
//            .backgroundColor = UIColor.green
    }

}
