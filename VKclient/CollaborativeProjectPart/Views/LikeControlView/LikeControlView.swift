//
//  LikeControlVeiw.swift
//  VKclient
//
//  Created by Александр Борисов on 09.06.2022.
//

import UIKit

protocol LikeControlProtocol: AnyObject {

    func pressLike(likeState: Bool, currentCounter: Int)
}


@IBDesignable class LikeControlView: UIView {


    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!

    weak var delegate: LikeControlProtocol?
    var counter = 0
    var isPressed = false


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }


    private func loadFromXIB() -> UIView {

        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "LikeControlView", bundle: bundle)
        guard let xibView = xib.instantiate(withOwner: self).first as? UIView else { return UIView() }

        return xibView
    }


    private func setup() {
        let xibView = loadFromXIB()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)

        counterLabel.text = String(counter)
    }

    func configure(isLiked: Bool, couter: Int) {
        self.counter = couter
        isPressed = isLiked
        likeState()
    }


    func likeState() {

        if isPressed {
            UIView.transition(with: heartImageView,
                              duration: 0.5,
                              options: [.transitionCrossDissolve]) { [weak self] in
                self?.heartImageView.image = UIImage(systemName: "heart.fill")
            } completion: { _ in

            }
        } else {
            UIView.transition(with: heartImageView,
                              duration: 0.5,
                              options: [.transitionCrossDissolve]) { [weak self] in
                self?.heartImageView.image = UIImage(systemName: "heart")
            } completion: { _ in

            }
        }
        counterLabel.text = String(counter)
    }


    @IBAction func pressLikeButton(_ sender: UIButton) {

        isPressed = !isPressed
        if isPressed {
            UIView.transition(with: self.counterLabel,
                              duration: 1,
                              options: [.transitionFlipFromTop]) { [weak self] in
                self?.counter += 1
            } completion: { _ in

            }
        } else {
            UIView.transition(with: self.counterLabel,
                              duration: 1,
                              options: [.transitionFlipFromBottom]) { [weak self] in
                self?.counter -= 1
            } completion: { _ in

            }
        }
        likeState()
        delegate?.pressLike(likeState: isPressed, currentCounter: counter)
    }
}
