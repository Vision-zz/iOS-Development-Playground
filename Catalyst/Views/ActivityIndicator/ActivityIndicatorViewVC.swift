    //
    //  ActivityIndicatorVC.swift
    //  BreakingStuff
    //
    //  Created by Sathya on 21/02/23.
    //

import UIKit

class ActivityIndicatorViewVC: UIViewController {


    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .systemBlue
        return activityIndicator

    }()

    lazy var controlButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var hideButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Activity Indicator View"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(activityIndicator)
        view.addSubview(controlButton)
        view.addSubview(hideButton)
        setConstraints()
        
        controlButton.addTarget(self, action: #selector(controlButtonOnClick), for: .touchDown)
        hideButton.addTarget(self, action: #selector(hideButtonOnClick), for: .touchDown)

    }

    @objc func controlButtonOnClick() {
        if(activityIndicator.isAnimating) {
            controlButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            activityIndicator.stopAnimating()
        } else {
            controlButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            activityIndicator.startAnimating()
        }
    }
    
    @objc func hideButtonOnClick() {
        if(activityIndicator.hidesWhenStopped) {
            hideButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            activityIndicator.hidesWhenStopped = false
        } else {
            hideButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            activityIndicator.hidesWhenStopped = true
        }
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            controlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            controlButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.height * 0.10)),
            hideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 35),
            hideButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.height * 0.10)),
        ])
    }
}
