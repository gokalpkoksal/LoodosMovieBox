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
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let movieYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieYearLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieTitleLabel.frame = CGRect(x: 20,
                                       y: 0,
                                       width: contentView.frame.size.width,
                                       height: contentView.frame.size.height)
        
        movieYearLabel.frame = CGRect(x: 250,
                                      y: 0,
                                      width: contentView.frame.size.width,
                                      height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: Movie) {
        movieTitleLabel.text = viewModel.title
        movieYearLabel.text = "Year: \(viewModel.year)"
    }

}
