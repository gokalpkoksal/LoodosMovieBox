//
//  MovieTableViewCell.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit
import Kingfisher

class MovieTableViewCellViewModel {
    let title: String
    let year: String
    
    init(title: String, year: String) {
        self.title = title
        self.year = year
    }
}

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    private let movieImageView = UIImageView()
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let movieYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private func setup() {
        contentView.addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        let movieImageBottomConstraint = movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        movieImageBottomConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        movieImageBottomConstraint.isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 300/446).isActive = true
        movieImageView.backgroundColor = .lightGray
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(movieTitleLabel)
        stackView.addArrangedSubview(movieYearLabel)
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: Movie) {
        movieTitleLabel.text = viewModel.title
        movieYearLabel.text = "Year: \(viewModel.year)"
        movieImageView.kf.setImage(with: URL(string:viewModel.image))
    }

}
