//
//  WeatherTableViewCell.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation
import UIKit

struct WeatherCellPresentation: Hashable {
    let currentDate: String
    let weekDay: String
    let temp: String
    let iconName: String
    let iconImage: UIImage?
    let weatherDetails: WeatherDetails?
}

class WeatherTableViewCell: UITableViewCell {
    
    var presentation: WeatherCellPresentation? {
        didSet {
            updateContents()
        }
    }
    
    private lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var tempratureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private let imageViewSize = 40.0
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //This has to be used as we would want to display addtional weeks for now not needed
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        currentDateLabel.text = nil
//        tempratureLabel.text = nil
//        weekDayLabel.text = nil
//        weatherIconImageView.image = nil
//    }
}

private extension WeatherTableViewCell {
    func setupView() {
        contentView.backgroundColor = .clear
        addSubview(currentDateLabel)
        addSubview(weekDayLabel)
        addSubview(tempratureLabel)
        addSubview(weatherIconImageView)
        
        NSLayoutConstraint.activate([
            //pinned to top left corner
            currentDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            currentDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            //centered vertically to the left
            weekDayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weekDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            //centered vertically to the right
            tempratureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempratureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            weatherIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherIconImageView.trailingAnchor.constraint(equalTo: tempratureLabel.leadingAnchor, constant: -4),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: imageViewSize),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: imageViewSize)
        ])
    }
    
    func updateContents() {
        currentDateLabel.text = presentation?.currentDate
        tempratureLabel.text = presentation?.temp
        weekDayLabel.text = presentation?.weekDay
        weatherIconImageView.image = presentation?.iconImage
    }
}

