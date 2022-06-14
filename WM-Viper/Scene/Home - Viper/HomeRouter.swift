//
//  HomeRouter.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import UIKit
import Resolver

class HomeRouter: PresenterToRouterHomeProtocol, Resolving {

    func routeToPhotoDetail(with photo: Photo, navigationController: UINavigationController) {
        let destination = resolver.resolve(PhotoDetailViewController.self)
        destination.router.dataStore.photo = photo
        navigationController.pushViewController(destination, animated: true)
    }
}
