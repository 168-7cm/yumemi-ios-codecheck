//
//  ProgramLanguage.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

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
        case "Kotlin":
            self = .kotlin
        default:
            self = .other
        }
    }

    var langColor: UIColor {
        switch self {
        case .java:
            return Asset.java.color
        case .javaScript:
            return Asset.javaScript.color
        case .python:
            return Asset.python.color
        case .ruby:
            return Asset.ruby.color
        case .swift:
            return Asset.swift.color
        case .kotlin:
            return Asset.kotlin.color
        case .other:
            return Asset.other.color
        }
    }
}
