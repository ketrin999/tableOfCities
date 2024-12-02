//
//  CityViewController.swift
//  tableOfCities
//
//  Created by Kate  on 20.11.2024.
//

import UIKit

class CityViewController: UIViewController, CityViewProtocol {

    private var presenter: CityPresenter!
    private let tableView = UITableView()

    private var countries: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Города и страны"
        view.backgroundColor = .systemBackground

        setupTableView()

        let service = CityService()
        presenter = CityPresenter(view: self, service: service)
        presenter.fetchCountries()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityCell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - CityViewProtocol

    func displayCountries(_ countries: [Country]) {
        self.countries = countries
        tableView.reloadData()
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries[section].cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }

        let city = countries[indexPath.section].cities[indexPath.row]
        cell.configure(with: city)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let label = UILabel()
        label.text = countries[section].name
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.frame = CGRect(x: 16, y: 0, width: tableView.bounds.width, height: 30)
        headerView.addSubview(label)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
