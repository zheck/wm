//
//  HomeInteractor.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation

final class HomeInteractor: PresenterToInteractorHomeProtocol {

    private var presenter: InteractorToPresenterHomeProtocol
    private var service: HomeService
    private var home: Home?
    private var currentPage = 0

    init(presenter: InteractorToPresenterHomeProtocol, service: HomeService) {
        self.presenter = presenter
        self.service = service
    }

    func fetch() async {
        do {
            let home = try await service.fetchHome(page: currentPage)
            self.home = home
            presenter.fetchHomeSuccess(home: home)
        } catch {
            presenter.fetchHomeFailed(error: error)
        }
    }

    func retrievePhoto(at index: Int) {
        guard let photo = home?.photos[index] else {
            presenter.retrievePhotoFailure()
            return
        }
        presenter.retrievePhotoSuccess(photo: photo)
    }
}
