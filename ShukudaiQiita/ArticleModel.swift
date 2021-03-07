//
//  ArticleModel.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/01/15.
//

import Foundation
import RxDataSources

struct ArticleModel: Codable {
  let title: String
  let created_at: String
  let url: String
}
