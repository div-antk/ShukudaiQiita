//
//  ArticleModel.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/01/15.
//

import Foundation
import RxDataSources

struct QiitaData {
    var items: [Qitta]
}

extension QiitaData: SectionModelType {
    
    typealias Item = Qiita
    
    init(original: QiitaData, items: [Qiita]) {
        self = original
        self.items = items
    }
}
