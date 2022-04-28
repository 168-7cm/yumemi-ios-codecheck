//
//  SearchRepositoryDataSource.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxDataSources

enum SectionModel {
    case header(title: String, items: [SectionItem])
    case filter(title: String, items: [SectionItem])
}

enum SectionItem {
    case main(repository: Repository)
    case filter(lang: ProgramingLanguage)
}

extension SectionModel: SectionModelType {

    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .header(title: _, items: let items):
            return items.map { $0 }
        case .filter(title: _, items: let items):
            return items.map { $0 }
        }
    }

    init(original: SectionModel, items: [SectionItem]) {
        switch original {
        case .header(title: let title, items: _):
            self = .header(title: title, items: items)
        case .filter(title: let title, items: _):
            self = .header(title: title, items: items)
        }
    }
}

extension SectionModel {

    var title: String {
        switch self {
        case .header(title: let title, items: _):
            return title
        case .filter(title: let title, items: _):
            return title
        }
    }
}
