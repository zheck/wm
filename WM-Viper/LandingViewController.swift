//
//  ViewController.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        router_dot_routeToHome()
    }

    private func router_dot_routeToHome() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let windows = sceneDelegate.window else { return }
        let destination = Container.resolveHome()
        let navigation = UINavigationController(rootViewController: destination)
        windows.rootViewController?.view.layoutSubviews()
        UIView.transition(with: windows, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            UIView.setAnimationsEnabled(false)
            windows.rootViewController = navigation
            UIView.setAnimationsEnabled(true)
        }, completion: nil)
    }
}

