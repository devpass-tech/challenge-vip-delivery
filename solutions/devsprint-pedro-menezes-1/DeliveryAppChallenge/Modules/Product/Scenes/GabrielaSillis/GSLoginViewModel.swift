//
//  GSLoginViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Gabriela Sillis on 21/07/22.
//

import Foundation

protocol GSLoginViewModelDelegate: AnyObject {
    func succeedLoginAuthentication(with session: Session)
    func failsLoginAuthentication()
    func startLoadingView()
    func stopLoadingView()
    func failsToConnectInternet()
}

protocol GSLoginViewModelProtocol {
    func checkDeviceConnectivityAndRequestAuthentication()
    func getUserEmailAndPasswordTextField(email: String, password: String)
    var delegate: GSLoginViewModelDelegate? { get set }
}

final class GSLoginViewModel: GSLoginViewModelProtocol {
    private let serviceLayer: GSLoginServiceRequesting = GSLoginService()
    private var userEmailAndPassword: UserEmailAndPasswordData?
    weak var delegate: GSLoginViewModelDelegate?
    
    func getUserEmailAndPasswordTextField(email: String, password: String) {
        userEmailAndPassword = UserEmailAndPasswordData(email: email, password: password)
    }
    
    func checkDeviceConnectivityAndRequestAuthentication() {
        let isDeviceConnectedToInternet = !ConnectivityManager.shared.isConnected
        if isDeviceConnectedToInternet {
            delegate?.failsToConnectInternet()
            return
        }
        makeLoginAuthenticationRequest()
    }
}

private extension GSLoginViewModel {
    enum UnwrapError: Error {
        case errorToUnwrap
    }
    
    func makeLoginAuthenticationRequest() {
        delegate?.startLoadingView()
        guard let userData = try? unwrapUserEmailAndPassword() else { return }
        serviceLayer.makeLoginAuthenticationRequest(userData: userData) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.stopLoadingView()
            self.handleAuthenticationRequestResponse(result: result)
        }
    }
    
    func unwrapUserEmailAndPassword() throws -> UserEmailAndPasswordData {
        if let userData = userEmailAndPassword {
            return userData
        }
        throw UnwrapError.errorToUnwrap
    }
    
    func handleAuthenticationRequestResponse(result: UserSessionResult) {
        switch result {
        case .success(let session):
            self.delegate?.succeedLoginAuthentication(with: session)
        case .failure:
            self.delegate?.failsLoginAuthentication()
        }
    }
}
