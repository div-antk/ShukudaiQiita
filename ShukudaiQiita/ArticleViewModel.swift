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
}
