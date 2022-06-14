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
            presenter.present(home: home)
        } catch {
            presenter.present(error: error)
        }
    }

    func photoWithID(_ id: String) -> Photo? {
        return home?.photos.first(where: { $0.id == id })
    }
}
