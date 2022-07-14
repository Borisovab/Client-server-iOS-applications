//
//  TestSearchGroupViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 12.07.2022.
//

import UIKit

class TestSearchGroupViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!

    let webGroupsSearch = WebDataRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

//    func printSearchedGroups(text: String) {
//        webGroupsSearch.sendGroupsSearchGetRequest(Str: searchTextField.text ?? "")
//    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        webGroupsSearch.sendGroupsSearchGetRequest(Str: searchTextField.text ?? "")
    }

}
