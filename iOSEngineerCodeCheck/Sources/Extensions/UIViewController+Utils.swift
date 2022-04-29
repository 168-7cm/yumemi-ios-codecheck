//
//  UIViewController+Utils.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {

    func showError(_ title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .default)
        alert.addAction(close)
        present(alert, animated: true, completion: {})
    }
}
