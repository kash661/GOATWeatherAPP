//
//  MainWeatherViewController.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import UIKit
import CoreLocation

class MainWeatherViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel: WeatherViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weatherCell")
        return tableView
    }()
    
    private let locationManager = CLLocationManager()
    
    init(viewModel: WeatherViewModel) {
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
        initViewModel()
        configureLocationManager()
    }
}

private extension MainWeatherViewController {
    func setupView() {
        view.backgroundColor = .white
        title = "Weather"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.circle"), style: .done, target:self, action: #selector(locationButtonTapped))
    }
    
    func initViewModel() {
        
    }
    
    func configureLocationManager() {
        
    }
    
    @objc func locationButtonTapped() {
        
    }
}

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {
          return UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        }
        
        return cell
    }
}


