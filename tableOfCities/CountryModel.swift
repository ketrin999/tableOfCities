//
//  CountryModel.swift
//  tableOfCities
//
//  Created by Kate  on 20.11.2024.
//

import Foundation

struct Country: Codable {
    let name: String
    let description: String
    let cities: [City]
}

struct City: Codable {
    let name: String
    let description: String
    let image: String
}

class CityService {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        let url = URL(string: "http://localhost:8080/api/cities")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
