//
//  SampleDataSource.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

protocol SampleDataSource {

    func fetchData(completion: @escaping (Result<DataModel, Error>) -> Void)
}
