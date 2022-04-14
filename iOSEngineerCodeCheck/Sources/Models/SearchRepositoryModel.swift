//
//  GitHubSearchModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol SearchRepositoryModelType {
    func searchRepository(keyword: String) -> Single<[Repository]>
}

final class SearchRepositoryModel: SearchRepositoryModelType {

    func searchRepository(keyword: String) -> Single<[Repository]> {

        let api = GitHubAPI.searchRepository(keyword: keyword)

        return Single.create { observer in

            AF.request(
                api.baseUrl.appendingPathComponent(api.path),
                method: api.method,
                parameters: api.parameters
            )
                .validate()
                .responseDecodable(of: GitHubSearchResponse.self) { response in
                    switch response.result {
                    case .success(let gitHubSearchResponse):
                        observer(.success(gitHubSearchResponse.items))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
