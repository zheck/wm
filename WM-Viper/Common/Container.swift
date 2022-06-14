//
//  Resolver.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver

class Container {

    static func resolveHome() -> HomeViewController {
        let service = DefaultHomeService()
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, service: service)
        let router = HomeRouter()
        view.inject(presenter: presenter)
        presenter.inject(view: view, interactor: interactor, router: router)

        return view
    }
}

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        register { PhotoDetailWorker() }.implements(PhotoDetailWorkerLogic.self)
        register { DefaultPhotoDetailService() }.implements(PhotoDetailService.self)
        register { PhotoDetailInteractor() }
            .implements(PhotoDetailBusinessLogic.self)
            .implements(PhotoDetailDataStore.self)
        register { PhotoDetailPresenter() }
            .implements(PhotoDetailPresentationLogic.self)
        register { PhotoDetailRouter() }
            .implements(PhotoDetailRoutingProtocol.self)
        register { PhotoDetailViewController() }
            .implements(PhotoDetailDisplayLogic.self)
            .resolveProperties { resolver, service in
                resolver.resolve(PhotoDetailRouter.self).inject(viewController: service)
                resolver.resolve(PhotoDetailPresenter.self).inject(display: service)
            }
    }
}
