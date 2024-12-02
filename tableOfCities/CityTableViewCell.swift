//
//  CityTableViewCell.swift
//  tableOfCities
//
//  Created by Kate  on 20.11.2024.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    private let cityImageView = UIImageView()
    private let cityNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 8
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityImageView)

        cityNameLabel.font = UIFont.systemFont(ofSize: 16)
        cityNameLabel.textColor = .black
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityNameLabel)

        NSLayoutConstraint.activate([
            cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityImageView.widthAnchor.constraint(equalToConstant: 50),
            cityImageView.heightAnchor.constraint(equalToConstant: 50),

            cityNameLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 16),
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with city: City) {
        cityNameLabel.text = city.name
        cityImageView.image = UIImage(named: "apple.image.playground")

        // Запрашиваем изображение
        ImageLoader.shared.loadImage(from: city.image) { [weak self] image in
            self?.cityImageView.image = image
        }
    }
}
