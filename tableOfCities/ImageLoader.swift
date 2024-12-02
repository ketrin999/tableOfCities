//
//  ImageLoader.swift
//  tableOfCities
//
//  Created by Kate  on 27.11.2024.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Проверяем кэш
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }

        // Проверяем URL
        guard let url = URL(string: "http://localhost:8080/api/images/\(urlString)") else {
            print("Некорректный URL: \(urlString)")
            completion(nil)
            return
        }

        // Загружаем изображение
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Ошибка загрузки изображения: \(error)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Не удалось декодировать данные в изображение")
                completion(nil)
                return
            }

            // Кэшируем изображение
            self?.cache.setObject(image, forKey: urlString as NSString)

            // Возвращаем изображение
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
