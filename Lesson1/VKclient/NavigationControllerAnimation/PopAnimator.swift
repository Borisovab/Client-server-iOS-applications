//
//  PopAnimator.swift
//  VKclient
//
//  Created by Александр Борисов on 22.06.2022.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {


    let durationTimeInterval: Double = 1

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTimeInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let sourceVC = transitionContext.viewController(forKey: .from),
              let destinationVC = transitionContext.viewController(forKey: .to)
        else { return }

        let conteinerFrame = transitionContext.containerView.frame

        let sourseFrame = CGRect(x: conteinerFrame.width, y: 0, width: conteinerFrame.height, height: conteinerFrame.width)

        let destinationFrame = sourceVC.view.frame
        transitionContext.containerView.addSubview(destinationVC.view)


        destinationVC.view.frame = CGRect(x: -conteinerFrame.height, y: 0, width: conteinerFrame.height, height: conteinerFrame.width)
        destinationVC.view.transform = CGAffineTransform(rotationAngle: .pi / 2)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {

            sourceVC.view.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
            sourceVC.view.frame = sourseFrame

            destinationVC.view.transform = .identity
            destinationVC.view.frame = destinationFrame

        } completion: { isDone in
            transitionContext.completeTransition(isDone)
        }
    }

}
