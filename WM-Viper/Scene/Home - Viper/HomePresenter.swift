//
//  HomePresenter.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

final class HomePresenter: ViewToPresenterHomeProtocol {

    private weak var view: PresenterToViewHomeProtocol?
    private var interactor: PresenterToInteractorHomeProtocol?
    private var router: PresenterToRouterHomeProtocol?

    private var photos: [Photo] = []

    func inject(
        view: PresenterToViewHomeProtocol,
        interactor: PresenterToInteractorHomeProtocol,
        router: PresenterToRouterHomeProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() async {
        await interactor?.fetch()
    }

    func numberOfItems() -> Int {
        return photos.count
    }

    func photo(at indexPath: IndexPath) -> PhotoViewModel? {
        let photo = photos[indexPath.row]
        let calendar = Calendar.current.dateComponents(
            [.day, .hour, .minute, .second],
            from: photo.lastUpdate,
            to: .now
        )
        var lastUpdate = "now"
        if let seconds = calendar.second {
            lastUpdate = "\(seconds) s"
        }

        return PhotoViewModel(
            id: photo.id,
            photoUrl: photo.url,
            userPicture: photo.user.picture,
            userName: photo.user.username,
            userSocial: photo.user.social,
            lastUpdate: lastUpdate,
            description: photo.description,
            numberOfLikes: photo.likes
        )
    }

    func didSelectItem(at indexPath: IndexPath) {
        interactor?.retrievePhoto(at: indexPath.item)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {

    func fetchHomeSuccess(home: Home) {
        self.photos = home.photos
        view?.onFetchSucceess()
    }

    func fetchHomeFailed(error: Error) {
        view?.onFetchFailure()
    }

    func retrievePhotoSuccess(photo: Photo) {
        guard let view = view else { return }
        router?.routeToPhotoDetail(with: photo, view: view)
    }

    func retrievePhotoFailure() {

    }
}

