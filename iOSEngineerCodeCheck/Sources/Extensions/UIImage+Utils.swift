//
//  UIImage+Utils.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIImage {
    /* URLで画像を指定する */
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
