//
//  ViewController.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/01/13.
//

import UIKit
import Alamofire
//import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  
  let count = 0;
    
  // 記事を入れる配列
  var articles = [ArticleModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
//    print(self.articles)
//    let nib = UINib(nibName: "Cell", bundle: nil)
//    tableView.register(nib, forCellReuseIdentifier: "Cell")
//    tableView.rowHeight = 80
    
    getArticles()

  }
  
  // セルの数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }
  
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      guard let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaTableViewCell", for: indexPath) as? QiitaTableViewCell else {
//          return UITableViewCell()
//      }
  
  // セルの構築
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let article = articles[indexPath.row]
    
    
    let title = cell.viewWithTag(1) as! UILabel
    title.text = article.title
        
    let created = cell.viewWithTag(2) as! UILabel
    created.text = article.created_at
    
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
          self.articles = articles
          self.tableView.reloadData()
          print(self.articles.count)
        } catch {
          print("error")
        }
      }
  }
}

