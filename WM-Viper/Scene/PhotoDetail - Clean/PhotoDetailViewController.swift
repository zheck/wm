//
//  PhotoDetailViewController.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import Resolver
import UIKit

protocol PhotoDetailDisplayLogic: AnyObject {
    func display(viewModel: PhotoDetailViewModel)
}

final class PhotoDetailViewController: UIViewController {

    @Injected var router: PhotoDetailRoutingProtocol
    @Injected private var interactor: PhotoDetailBusinessLogic

    private var viewModel: PhotoDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetch()
    }

    private func setupInterface() {
        view.backgroundColor = .white
    }

    private func setupConstraints() {

    }
}

extension PhotoDetailViewController: PhotoDetailDisplayLogic {

    func display(viewModel: PhotoDetailViewModel) {
        Task { @MainActor in
            self.viewModel = viewModel
        }
    }
}
