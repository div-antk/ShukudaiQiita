//
//  ViewController.swift
//  ShukudaiQiita
//
//  Created by Takuya Ando on 2021/01/13.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var search: UIButton!
    
    private let disposeBag = DisposeBag()
    
    let count = 0;
    
    // 記事を入れる配列
    var articles = [ArticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getArticles(keyword: "")
        searchButtonTap()
    }
    
    // 虫めがねボタン押したとき
    func searchButtonTap() {
        search.rx.tap
            .subscribe(onNext: {(next) in
                self.getArticles(keyword: self.searchTextField.text!)
            })
            .disposed(by: disposeBag)
    }
    
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    // セルの構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = articles[indexPath.row]
        
        // タイトルをセルに反映
        let title = cell.viewWithTag(1) as! UILabel
        title.text = article.title
        
        // 作成日時をセルに反映
        let created = cell.viewWithTag(2) as! UILabel
        created.text = article.created_at
        
        return cell
    }
    
    // セルをクリックしたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // WebViewControllerにurlを渡す
        let webViewController = WebViewController()
        webViewController.modalTransitionStyle = .crossDissolve
        let article = articles[indexPath.row]
        
        // 遷移先で使うためにUserDefaultsへURLを保存
        UserDefaults.standard.set(article.url, forKey: "url")
        // webViewControllerへ遷移
        present(webViewController, animated: true, completion: nil)
    }
    
    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
        
    func getArticles(keyword:String) {
        
        // 受け取った検索キーワードが日本語の場合はエラーになるのでパーセントエンコーディングする
        let keywordEncode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // keywordとSwiftタグに限定してAPIを叩く
        let url = "https://qiita.com/api/v2/items?query=\(keywordEncode!)+tag:Swift"
        
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
                    
                } catch {
                    print("error")
                }
            }
    }
}

