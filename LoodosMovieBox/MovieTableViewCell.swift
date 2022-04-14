//
//  MovieTableViewCell.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit

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
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieTitleLabel.frame = CGRect(x: 10,
                                       y: 0,
                                       width: contentView.frame.size.width,
                                       height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: MovieTableViewCellViewModel) {
        movieTitleLabel.text = viewModel.title
    }

}
