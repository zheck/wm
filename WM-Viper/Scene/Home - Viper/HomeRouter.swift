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

    func routeToPhotoDetail(with photo: Photo, view: PresenterToViewHomeProtocol) {
        guard let viewControler = view as? HomeViewController else { return }
        let destination = resolver.resolve(PhotoDetailViewController.self)
        destination.router.dataStore.photo = photo
        viewControler.navigationController?.pushViewController(destination, animated: true)
    }
}
