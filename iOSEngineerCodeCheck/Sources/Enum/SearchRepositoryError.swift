//
//  SearchRepositoryError.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum SearchRepositoryError: Error {

    case invalidUrlError
    case connectionError
    case responseParseError
    case apiError

    func errorMessage() -> String {
        switch self {
        case .invalidUrlError:
            return ""
        case .connectionError:
            return ""
        case .responseParseError:
            return ""
        case .apiError:
            return ""
        }
    }
}
