//
//  HomeProtocols.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import UIKit

protocol ViewToPresenterHomeProtocol: Any {
    func start() async
    func showPhotoDetail(with id: String, navigationController: UINavigationController)
}

protocol PresenterToViewHomeProtocol: Any {
    func display(viewModel: HomeViewModel)
    func displayError(_ error: String)
}

protocol PresenterToRouterHomeProtocol: Any {
    func routeToPhotoDetail(with photo: Photo, navigationController: UINavigationController)
}

protocol PresenterToInteractorHomeProtocol: Any {
    func fetch() async
    func photoWithID(_ id: String) -> Photo?
}

protocol InteractorToPresenterHomeProtocol: Any {
    func present(home: Home)
    func present(error: Error)
}
