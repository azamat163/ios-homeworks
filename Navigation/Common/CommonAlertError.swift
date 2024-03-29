//
//  CommonAlertError.swift
//  Navigation
//
//  Created by a.agataev on 14.02.2022.
//

import Foundation
import UIKit

final class CommonAlertError {
    static func present(vc: UIViewController, with error: LocalizedError) {
        let OkAlertAction = UIAlertAction(title: "Ok", style: .default)
        let alertVC = UIAlertController(
            title: "Ошибка",
            message: error.errorDescription,
            preferredStyle: .alert
        )
        alertVC.addAction(OkAlertAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
    
    static func present(vc: UIViewController, with message: String) {
        let OkAlertAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in
            vc.navigationController?.popViewController(animated: true)
        })
        let alertVC = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .alert
        )
        alertVC.addAction(OkAlertAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
    
    static func present(vc: UIViewController, message: String) {
        let OkAlertAction = UIAlertAction(title: "Ok", style: .default)
        let alertVC = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alertVC.addAction(OkAlertAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
}
