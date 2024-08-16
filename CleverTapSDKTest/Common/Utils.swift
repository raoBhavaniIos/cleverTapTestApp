//
//  Utils.swift
//  CleverTapSDKTest
//
//  Created by Bhawanisingh Rao on 16/08/24.
//

import Foundation
import UIKit
class Utils{
    static let shared = Utils()
    private init(){}
    func showLoadingPopup(on viewController:UIViewController) {
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: 10)
        ])
        loadingIndicator.startAnimating()
        viewController.present(alert, animated: true, completion: nil)
    }
    func hideLoadingPopup(on viewController:UIViewController){
            viewController.dismiss(animated: true, completion: nil)
    }
    func showErrorPopup(on viewController:UIViewController, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
