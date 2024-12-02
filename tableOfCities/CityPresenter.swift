//
//  CityPresenter.swift
//  tableOfCities
//
//  Created by Kate  on 27.11.2024.
//

import Foundation

class CityPresenter {
    weak var view: CityViewProtocol?
    private let cityService: CityService

    private var countries: [Country] = []

    init(view: CityViewProtocol, service: CityService) {
        self.view = view
        self.cityService = service
    }

    func fetchCountries() {
        cityService.fetchCountries { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries
                    self.view?.displayCountries(countries)
                case .failure(let error):
                    self.view?.displayError("Ошибка: \(error.localizedDescription)")
                }
            }
        }
    }
}
