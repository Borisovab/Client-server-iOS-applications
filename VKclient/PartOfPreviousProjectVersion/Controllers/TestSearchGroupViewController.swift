//
//  TestSearchGroupViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 12.07.2022.
//

import UIKit

class TestSearchGroupViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!

    let webGroupsSearch = SomeMethods()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        webGroupsSearch.sendGroupsSearchGetRequest(Str: searchTextField.text ?? "")
    }

}
