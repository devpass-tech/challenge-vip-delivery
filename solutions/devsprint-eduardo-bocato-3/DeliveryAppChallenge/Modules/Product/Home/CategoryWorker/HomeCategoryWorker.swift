//
//  CategoryWorker.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 08/11/22.
//

import Foundation


protocol CategoryWorkerProtocol {
    func fetchCategoryItems(_ completion: @escaping (Result<[CategoryItem], MenuItemErorr>) -> Void)
}

final class HomeCategoryWorker: CategoryWorkerProtocol {

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol){
        self.apiService = apiService
    }

    func fetchCategoryItems(_ completion: @escaping (Result<[CategoryItem], MenuItemErorr>) -> Void) {
        apiService.getMenuItems { result in
            do {
                let categoryItems: [CategoryItem] = try result
                    .get()
                    .map {
                        .init(title: $0.name, imageName: "pizza")
                    }
                completion(.success(categoryItems))

            }catch {
                completion(.failure(.categoryFetchingError))
            }
        }
    }
}

extension HomeCategoryWorker {

    static func getCategoryWorker() -> HomeCategoryWorker {
        
        let apiService = APIService(networkManager: NetworkManager())
        return HomeCategoryWorker(apiService: apiService)
    }
}
