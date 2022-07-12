//
//  CustomInteractiveTransition.swift
//  VKclient
//
//  Created by Александр Борисов on 22.06.2022.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var complete = false
    var isAnimationStarted = false

    
    @objc func onPan(_ recognizer: UIScreenEdgePanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            isAnimationStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
            self.pause()

        case .changed:
            var translation = recognizer.translation(in: recognizer.view)

            if translation.x < 0 { translation.x = -translation.x }
            let percentComplete = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, percentComplete))
            if progress > 0.3 { complete = true }
            self.update(progress)

        case .ended:
            isAnimationStarted = false
            if complete {
                self.finish()
            } else {
                self.cancel()
            }

        default:
            isAnimationStarted = false
            return
        }
    }

}
