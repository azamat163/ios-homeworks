//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by a.agataev on 01.08.2022.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        let reason = "Please authenticate to proceed."
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else { return }
        context
            .evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason,
                reply: { success, error in
                    DispatchQueue.main.async {
                        if success {
                            authorizationFinished(true)
                        } else {
                            guard let error = error else { return }
                            print(error.localizedDescription)
                            authorizationFinished(false)
                        }
                    }
                }
            )
    }
}
