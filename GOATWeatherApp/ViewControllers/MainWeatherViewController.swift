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
    
    private var locationManager: CLLocationManager?
    
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
        viewModel.fetchWeatherData(latitude: viewModel.userCoordinates?.latitude ?? -25, longitude: viewModel.userCoordinates?.longitude ?? -65) // was unclear of what to do if user says no, so i just put default coords
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.locationButtonTappedHandler = { [weak self] in
            guard let self = self else { return }
            self.locationManager?.stopUpdatingLocation()
            self.viewModel.disableLocationButton = true
        }
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    @objc func locationButtonTapped() {
        if !viewModel.disableLocationButton {
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
            if let location = locationManager?.location {
                let coordinates = UserCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                viewModel.userCoordinates = coordinates
            }
        }
    }
}

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dailyWeatherCellPresentation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        }
        
        let presentation = viewModel.fetchCellData(at: indexPath)
        cell.presentation = presentation
        return cell
    }
}

extension MainWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            viewModel.userCoordinates = UserCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            viewModel.fetchCityAndCountry(from: location) { city, error in
                if let error = error {
                    print(error) // title would stay weather
                }
                self.title = city ?? "Weather"
            }
        }
    }
}
