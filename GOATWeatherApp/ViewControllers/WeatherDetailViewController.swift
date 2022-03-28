//
//  WeatherDetailViewController.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var weatherDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let viewModel: WeatherDetailViewModel // dont need this for this app, but this will be required for a bigger app and to follow the MVVM pattern
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension WeatherDetailViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(weatherDescription)
        
        NSLayoutConstraint.activate([
            weatherDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        weatherDescription.text = viewModel.weatherDescriptionData.weatherDescription
    }
    
}
