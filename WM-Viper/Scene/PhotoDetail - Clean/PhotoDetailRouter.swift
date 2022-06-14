//
//  PhotoDetailRouter.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

protocol PhotoDetailRoutingLogic {
}

protocol PhotoDetailDataPassing {
    var dataStore: PhotoDetailDataStore { get set }
}

typealias PhotoDetailRoutingProtocol = PhotoDetailRoutingLogic & PhotoDetailDataPassing

final class PhotoDetailRouter: PhotoDetailRoutingProtocol, Resolving {

    @Injected var dataStore: PhotoDetailDataStore

    private var viewController: PhotoDetailViewController?

    func inject(viewController: PhotoDetailViewController) {
        self.viewController = viewController
    }
}
