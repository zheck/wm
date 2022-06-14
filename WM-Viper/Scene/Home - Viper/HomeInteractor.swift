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

    init(presenter: InteractorToPresenterHomeProtocol, service: HomeService) {
        self.presenter = presenter
        self.service = service
    }

    func fetch() {
        let home = service.fetchHome()
        self.home = home
        presenter.present(home: home)
    }

    func photoWithID(_ id: String) -> Photo? {
        return home?.photos.first(where: { $0.id == id })
    }
}
