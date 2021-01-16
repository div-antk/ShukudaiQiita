//
//  ViewController.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/01/13.
//

import UIKit
import Alamofire
//import SwiftyJSON
//import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  
  let count = 0;
  
  private var articles:ArticleModel?
  
  // 記事を入れる配列
  //  var articles = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    getArticles()
  }
  
  // セルの数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  // セルの構築
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    return cell
  }
  
  // セルの高さ
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  //  func getArticles(keyword:String) {
  func getArticles() {
    // APIキー
    
    //    let url = "https://qiita.com/api/v2/items?query=\(keyword)+title:やってみる"
    let url = "https://qiita.com/api/v2/items?query=tag:Swift"
    
    // Alamofireを使ってHTTPリクエストを投げる
    AF.request(url,
               method: .get,
               parameters: nil,
               encoding: JSONEncoding.default,
               headers: nil)
      .responseJSON{ (response) in
        let decoder: JSONDecoder = JSONDecoder()
        do {
          let articles: [ArticleModel] = try decoder.decode([ArticleModel].self, from: response.data!)
          print(articles)
        } catch {
          print("error")
        }
      }
  }
}

