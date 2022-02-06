//
//  HomeDataSource.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation

typealias HomeDataSouceCompletion = (Result<Home, Error>) -> Void

/// Protocol with methods that Resository will have access to get data from Data Source (API/ DB/ CACHE /ETC)
protocol HomeDataSource {
    func fetchHomeData(completion: @escaping HomeDataSouceCompletion)
}
