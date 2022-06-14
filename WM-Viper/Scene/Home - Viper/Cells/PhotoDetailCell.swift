//
//  HomeCollectionViewCell.swift
//  WM-Viper
//
//  Created by Fong Zhou on 14/06/2022.
//

import Foundation
import UIKit
import Kingfisher

class PhotoDetailCell: UICollectionViewCell {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5.0
        view.layer.masksToBounds = false
        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.small
        return stackView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    private let socialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    private lazy var updateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CornerRadius.medium
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .red
        button.setTitleColor(.gray, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
      super.init(frame: frame)
      setupInterface()
      setupConstraints()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    private func setupInterface() {
        addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(userStackView)
        userStackView.addArrangedSubview(nameLabel)
        userStackView.addArrangedSubview(socialLabel)
        containerView.addSubview(updateLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(likeButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.medium),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.medium),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            userStackView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Spacing.medium),
            userStackView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            updateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.medium),
            updateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Spacing.medium),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.medium),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.medium),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Spacing.medium),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            likeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            likeButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }

    func setup(with viewModel: PhotoViewModel) {
        if let url = viewModel.userPicture {
            logoImageView.kf.setImage(with: url)
        }
        nameLabel.text = viewModel.userName
        socialLabel.text = viewModel.userSocial
        updateLabel.text = viewModel.lastUpdate
        imageView.kf.setImage(with: viewModel.photoUrl)
        descriptionLabel.text = viewModel.description
        likeButton.setTitle("\(viewModel.numberOfLikes)", for: .normal)
    }

}
