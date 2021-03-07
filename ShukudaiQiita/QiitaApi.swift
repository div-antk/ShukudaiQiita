//
//  QiitaApi.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/03/08.
//

import Moya

enum QiitaApi {
    case getArticles
}

extension QiitaApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://qiita.com")!
    }
    
    var path: String {
        return "/api/v2/items"
    }
    
    var method: Method {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["per_page" : "10"], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
