//
//  CityViewProtocol.swift
//  tableOfCities
//
//  Created by Kate  on 27.11.2024.
//

import Foundation

protocol CityViewProtocol: AnyObject {
    func displayCountries(_ countries: [Country])
    func displayError(_ message: String)
}
