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
}

extension SearchRepositoryError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrlError: return "あ"
        case .connectionError: return "あ"
        case .responseParseError: return "あ"
        case .apiError: return "あ"
        }
    }
}
