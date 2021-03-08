//
//  QiitaRepository.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/03/08.
//

import Moya
import RxSwift

typealias QiitaAPIResponse = (( _ response: Qiita?, _ error: Swift.Error?) -> Void)

final class QiitaRepository {
    
    private static let qiitaApiProvider = MoyaProvider<QiitaApi>()
    private static let disposeBag: DisposeBag = DisposeBag()
}

extension QiitaRepository {
    
    static func fetchQiita() -> Observable<[Qiita]> {
        return qiitaApiProvider.rx.request(.getArticles)
            .map([Qiita].self)
            .asObservable()
    }
}
