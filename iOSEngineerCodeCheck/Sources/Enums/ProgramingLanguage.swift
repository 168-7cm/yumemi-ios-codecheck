//
//  ProgramLanguage.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

enum ProgramingLanguage {

    case java
    case javaScript
    case python
    case ruby
    case swift
    case kotlin
    case other

    init(rawValue: String?) {
        switch rawValue {
        case "Java":
            self = .java
        case "JavaScript":
            self = .javaScript
        case "Python":
            self = .python
        case "Ruby":
            self = .ruby
        case "Swift":
            self = .swift
        default:
            self = .other
        }
    }

    // TODO: 色を設定する
    var langColor: UIColor {
        switch self {
        case .java:
            return .blue
        case .javaScript:
            return .label
        case .python:
            return .brown
        case .ruby:
            return .blue
        case .swift:
            return .label
        case .kotlin:
            return .blue
        case .other:
            return .red
        }
    }
}
