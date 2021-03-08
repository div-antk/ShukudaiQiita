//
//  ArticleViewModel.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/03/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticleViewModelInputs {
    
}

protocol ArticleViewModelOutputs {
    
    var articles: Observable<[QiitaData]> {get}
    var error: Observable<Error> {get}
}

protocol ArticleViewModelType {
    var inputs: ArticleViewModelInputs {get}
    var outputs: ArticleViewModelOutputs {get}
}

class ArticleViewModel: ArticleViewModelOutputs {
    
    let articles: Observable<[QiitaData]>
    let error: Observable<Error>
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        let _articles = PublishRelay<[QiitaData]>()
        let _error = PublishRelay<Error>()
        
        QiitaRepository.fetchQiita()
            .subscribe(onNext: { response in
                let dataSource = QiitaData.init(items: response)
                _articles.accept([dataSource])
            }, onError: { error in
                _error.accept(error)
            }).disposed(by: disposeBag)
        
        self.articles = _articles.asObservable()
        self.error = _error.asObservable()
    }
}
