//
//  TextViewVC.swift
//  Catalyst
//
//  Created by Sathya on 10/03/23.
//

import UIKit

class TextViewVC: UIViewController {

    lazy var username: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = Constants.ContrastForeground
        return textField
    }()

    lazy var password: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.enablePasswordToggle()
        let passwordRuleDescriptor = "required: upper; required: lower; required: digit; required: special; minlength: 8;"
        textField.passwordRules = UITextInputPasswordRules(descriptor: passwordRuleDescriptor)
        textField.backgroundColor = Constants.ContrastForeground
        return textField
    }()

    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = Constants.UIBackgroundColor
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(tapGesture)

        configureUI()
        addConstraints()
    }

    @objc func onTap() {
//        view.endEditing(true)
        username.resignFirstResponder()
    }

    private func configureUI() {
        title = "Text View"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Constants.UIBackgroundColor

        stackView.addArrangedSubview(username)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            username.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7),
            password.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7),

            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
        ])
    }

}

extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }else{
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }

    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.tintColor = .secondaryLabel
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchDown)
        self.rightView = button
        self.rightViewMode = .whileEditing
    }

    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }

}
