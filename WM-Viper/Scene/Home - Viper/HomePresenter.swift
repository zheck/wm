//
//  HomePresenter.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import UIKit

final class HomePresenter: ViewToPresenterHomeProtocol {

    private var view: PresenterToViewHomeProtocol?
    private var interactor: PresenterToInteractorHomeProtocol?
    private var router: PresenterToRouterHomeProtocol?

    func inject(
        view: PresenterToViewHomeProtocol,
        interactor: PresenterToInteractorHomeProtocol,
        router: PresenterToRouterHomeProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func start() async {
        await interactor?.fetch()
    }

    func showPhotoDetail(with id: String, navigationController: UINavigationController) {
        guard let photo = interactor?.photoWithID(id) else { return }
        router?.routeToPhotoDetail(with: photo, navigationController: navigationController)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {

    func present(home: Home) {
        let pictures: [PhotoViewModel] = home.photos.map({
            let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: $0.lastUpdate, to: .now)

            // don't want to waste time here, just gave in days
            var string = "now"
            if let seconds = calendar.second {
                string = "\(seconds) s"
            }

            return PhotoViewModel(
                id: $0.id,
                photoUrl: $0.url,
                userPicture: $0.user.picture,
                userName: $0.user.username,
                userSocial: $0.user.social,
                lastUpdate: string,
                description: $0.description,
                numberOfLikes: $0.likes)
        })
        let viewModel = HomeViewModel(pictures: pictures)
        view?.display(viewModel: viewModel)
    }

    func present(error: Error) {
    }
}

