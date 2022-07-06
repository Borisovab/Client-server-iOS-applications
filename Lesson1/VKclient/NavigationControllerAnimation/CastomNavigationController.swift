//
//  CastomNavigationController.swift
//  VKclient
//
//  Created by Александр Борисов on 22.06.2022.
//

import UIKit

class CastomNavigationController: UINavigationController {

    let interactiveTransition = CustomInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
}


extension CastomNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.isAnimationStarted ? interactiveTransition : nil
    }


    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        var animation: UIViewControllerAnimatedTransitioning?

        if operation == .push {
            animation = PushAnimator()
        }

        if operation == .pop {
            animation = PopAnimator()
        }

        return animation
    }
}
