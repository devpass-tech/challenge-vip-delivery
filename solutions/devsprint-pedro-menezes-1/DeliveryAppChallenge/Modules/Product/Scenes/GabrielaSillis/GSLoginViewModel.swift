//
//  GSLoginViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Gabriela Sillis on 21/07/22.
//

import Foundation

protocol GSLoginViewModelDelegate: AnyObject {
    func successLoginAuthenticationRequest(session: Session)
    func failureLoginAuthenticationRequest()
    func startLoadingView()
    func stopLoadingView()
}

protocol GSLoginViewModelProtocol {
    func makeLoginAuthenticationRequest()
    func getUserEmailAndPasswordTextField(email: String, password: String)
    func delegate(_ delegate: GSLoginViewModelDelegate?)
}

final class GSLoginViewModel: GSLoginViewModelProtocol {
    private weak var delegate: GSLoginViewModelDelegate?
    private let serviceLayer: GSLoginNetworkRequesting = GSLoginNetworkManager()
    private var userEmailAndPassword: UserEmailAndPasswordData?
    
    func makeLoginAuthenticationRequest() {
        delegate?.startLoadingView()
        guard let userData = try? unwrapUserEmailAndPassword() else { return }
        serviceLayer.makeLoginAuthenticationRequest(userData: userData) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.stopLoadingView()
            self.handleAuthenticationRequestResponse(result: result)
        }
    }
    
    func getUserEmailAndPasswordTextField(email: String, password: String) {
        userEmailAndPassword = UserEmailAndPasswordData(email: email, password: password)
    }
    
    func delegate(_ delegate: GSLoginViewModelDelegate?) {
        self.delegate = delegate
    }
}

private extension GSLoginViewModel {
    enum UnwrapError: Error {
        case errorToUnwrap
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
            self.delegate?.successLoginAuthenticationRequest(session: session)
        case .failure:
            self.delegate?.failureLoginAuthenticationRequest()
        }
    }
}
