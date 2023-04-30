//
//  FirebaseAuthAdapter.swift
//  UberClone
//
//  Created by Gilberto Silva on 19/04/23.
//

import Foundation
import FirebaseAuth

public final class FirebaseAuthAdapter {
    
    private func handleResultCallBack(_ result: AuthDataResult?,
                                      _ error: Error?,
                                      _ completion: (AutenticationResult) -> Void) {
        if let result = result {
            let userModel = UserModel(uid: result.user.uid)
            completion(.success(userModel))
        } else if let error = error {
            guard
                let errorParse = error as NSError?,
                let code = AuthErrorCode(rawValue: errorParse.code)
            else { return completion(.failure(.internalError)) }
            
            switch code {
            case .networkError:
                completion(.failure(.networkError))
            case .userNotFound:
                completion(.failure(.userNotFound))
            case .userTokenExpired:
                completion(.failure(.userTokenExpired))
            case .tooManyRequests:
                completion(.failure(.tooManyRequests))
            case .invalidAPIKey:
                completion(.failure(.invalidAPIKey))
            case .appNotAuthorized:
                completion(.failure(.appNotAuthorized))
            case .keychainError:
                completion(.failure(.keychainError))
            case .internalError:
                completion(.failure(.internalError))
            case .invalidUserToken:
                completion(.failure(.invalidUserToken))
            case .userDisabled:
                completion(.failure(.userDisabled))
            default:
                completion(.failure(.internalError))
            }
        }
    }
}

// MARK: - AutenticationClient
extension FirebaseAuthAdapter: AutenticationClient {
    public func auth(authenticationModel: AuthenticationModel,
                       completion: @escaping (AutenticationResult) -> Void) {
        Auth.auth().signIn(withEmail: authenticationModel.email, password: authenticationModel.password) { [weak self] result, error in
            guard let self = self else { return }
            self.handleResultCallBack(result, error, completion)
        }
    }
}

// MARK: - AutenticationCreateClient
extension FirebaseAuthAdapter: AuthCreateClient {
    
    public func create(authenticationModel: AuthenticationModel,
                       completion: @escaping (AutenticationResult) -> Void) {
        Auth.auth().createUser(withEmail: authenticationModel.email, password: authenticationModel.password) { [weak self] result, error in
            guard let self = self else { return }
            self.handleResultCallBack(result, error, completion)
        }
    }
}

// MARK: - AuthListenStateClient
extension FirebaseAuthAdapter: AuthGetStateClient {
    
    public func getState(completion: @escaping (Bool) -> Void) {
        _ = Auth.auth().addStateDidChangeListener({ _, user in
            completion(user != nil)
        })
    }
}

// MARK: - AuthLogoutClient
extension FirebaseAuthAdapter: AuthLogoutClient {
    
    public func logout(completion: @escaping (Bool) -> Void) {
        do {
           try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
