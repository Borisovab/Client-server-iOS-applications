//
//  ViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var pushTheButton: UIButton!

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view10: UIView!

    let goFromLogin = "goFromLogin"

    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.cornerRadius = 9
        view2.layer.cornerRadius = 9
        view3.layer.cornerRadius = 9
        view4.layer.cornerRadius = 9
        view5.layer.cornerRadius = 9
        view6.layer.cornerRadius = 9
        view7.layer.cornerRadius = 9
        view8.layer.cornerRadius = 9
        view9.layer.cornerRadius = 9
        view10.layer.cornerRadius = 9

        view1.alpha = 0
        view2.alpha = 0
        view3.alpha = 0
        view4.alpha = 0
        view5.alpha = 0
        view6.alpha = 0
        view7.alpha = 0
        view8.alpha = 0
        view9.alpha = 0
        view10.alpha = 0

        loginText.alpha = 0
        passwordText.alpha = 0
        logoImage.alpha = 0
        pushTheButton.alpha = 0


        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(recognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewAnimation()


        UIView.animateKeyframes(withDuration: 0.1,
                                delay: 0,
                                options: [.calculationModeLinear]) { [weak self] in
            guard let self = self else { return }
            self.loginText.transform = CGAffineTransform(rotationAngle: .leastNormalMagnitude).translatedBy(x: 400, y: 0)

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0) {
                self.passwordText.transform = CGAffineTransform(rotationAngle: .leastNormalMagnitude).translatedBy(x: -400, y: 0)
            }

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0) {
                self.logoImage.transform = CGAffineTransform(rotationAngle: .greatestFiniteMagnitude).translatedBy(x: -400, y: 400)
            }

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0) {
                self.pushTheButton.transform = CGAffineTransform(rotationAngle: .pi).translatedBy(x: 1400, y: -1400)
            }

        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.loginText.alpha = 1
                self.loginText.transform = .identity
                self.passwordText.alpha = 1
                self.passwordText.transform = .identity
                self.logoImage.alpha = 1
                self.logoImage.transform = .identity
                self.pushTheButton.alpha = 1
                self.pushTheButton.transform = .identity
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: []) { [weak self] in
            guard let self = self else { return }
            self.pushTheButton.frame.origin.y -= 100
        } completion: { _ in
          
        }
    }


    func viewAnimation() {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view1.alpha = 0
            self?.view2.alpha = 1

        } completion: { _ in
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.view2.alpha = 0
                self?.view3.alpha = 1

            } completion: { _ in
                UIView.animate(withDuration: 0.4) { [weak self] in
                    self?.view3.alpha = 0
                    self?.view4.alpha = 1

                } completion: { _ in
                    UIView.animate(withDuration: 0.4) { [weak self] in
                        self?.view4.alpha = 0
                        self?.view5.alpha = 1

                    } completion: { _ in
                        UIView.animate(withDuration: 0.4) { [weak self] in
                            self?.view5.alpha = 0
                            self?.view6.alpha = 1

                        } completion: { _ in
                            UIView.animate(withDuration: 0.4) { [weak self] in
                                self?.view6.alpha = 0
                                self?.view7.alpha = 1

                            } completion: { _ in
                                UIView.animate(withDuration: 0.4) { [weak self] in
                                    self?.view7.alpha = 0
                                    self?.view8.alpha = 1

                                } completion: { _ in
                                    UIView.animate(withDuration: 0.4) { [weak self] in
                                        self?.view8.alpha = 0
                                        self?.view9.alpha = 1

                                    } completion: { _ in
                                        UIView.animate(withDuration: 0.4) { [weak self] in
                                            self?.view9.alpha = 0
                                            self?.view10.alpha = 1

                                        } completion: { _ in
                                            UIView.animate(withDuration: 0.4) { [weak self] in
                                                self?.view1.alpha = 1
                                                self?.view10.alpha = 0

                                            } completion: { [weak self] _ in
                                                self?.viewAnimation()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @IBAction func pressButtonAction(_ sender: UIButton) {

        let login = self.loginText.text!
        let password = self.passwordText.text!

        if login == "aaa" && password == "aaa" {

            //меняю текст в поле login
            UIView.transition(with: loginText,
                              duration: 0.7,
                              options: [.transitionFlipFromBottom]) {[weak self] in
                guard let self = self else { return }
                self.loginText.textColor = #colorLiteral(red: 0, green: 0.6641527414, blue: 0, alpha: 1)
                self.loginText.text = "access is allowed 👍"
            } completion: { _ in

            }

            UIView.transition(with: passwordText,
                              duration: 1,
                              options: [.curveEaseIn, .transitionFlipFromLeft, .repeat]) {[weak self] in
                guard let self = self else { return }
            } completion: { _ in

            }

            // анимация ухода для полей login и password
            UIView.animate(withDuration: 4,
                           delay: 0,
                           options: [.transitionCurlUp, .transitionFlipFromLeft]) { [weak self] in
                guard let self = self else { return }
                self.loginText.transform = CGAffineTransform(rotationAngle: .ulpOfOne).translatedBy(x: 0, y: 100).scaledBy(x: 1.5, y: 1.5)
                self.loginText.alpha = 0
                self.passwordText.transform = CGAffineTransform(rotationAngle: .ulpOfOne).translatedBy(x: 40, y: 140).scaledBy(x: 0.1, y: 0.1)
                self.passwordText.alpha = 0
            } completion: { _ in

            }

            // анимация ухода кнопки с дальнейшим переходом на другой экран
            UIView.animate(withDuration: 3,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.2,
                           options: []) { [weak self] in
                guard let self = self else { return }
                self.pushTheButton.transform = CGAffineTransform(translationX: 0, y: 250)
                self.pushTheButton.alpha = 0.3
            } completion: { [weak self] _ in
                guard let self = self else { return }

                self.performSegue(withIdentifier: self.goFromLogin, sender: self)
            }
        } else{

            let alert = UIAlertController(title: "Ошибка", message: "Неверные логин или пароль", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }

        
    }


}

