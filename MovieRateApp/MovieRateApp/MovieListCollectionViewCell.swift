//
//  MovieListCollectionViewCell.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/28.
//

import UIKit
import SnapKit
import Kingfisher
final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MoveListCollectionViewCell"
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()

    private lazy var userRatingLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()

    func update(_ movie: Movie) {
        setupView()
        setupLayout()

        imageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title
        userRatingLabel.text = "⭐️ \(movie.userRating)"
    }
}
private extension MovieListCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8

        backgroundColor = .systemBackground
    }

    func setupLayout() {
        [imageView,
         titleLabel,
         userRatingLabel]
            .forEach {
                self.addSubview($0)
            }

        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(imageView.snp.width)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8.0)
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
        }

        userRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
}
