//
//  ViewController.swift
//  qiita_api
//
//  Created by 村上拓麻 on 2018/08/28.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SFSafariViewControllerDelegate,UISearchBarDelegate{

    let search_error = error.search_error       //検索時のエラー文
    let no_search = error.notext_error          //何も入力されていない時のエラー
    
    let api_req = API_data()        //apiのリクエストクラスを継承
    var articles : [[String:String?]] = []

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        title = "記事検索"
        searchBar.delegate = self
        searchBar.placeholder = "検索したい言語"
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        articles = []
     
        if searchBar.text != "" {
            api_req.request(keyword:searchBar.text!){ response in
                self.articles = response
                print("受け取ったデータ",self.articles)
                self.table.reloadData()
            
                guard self.articles != [] else{
                    self.alert(self.search_error.error_description!)
                    self.table.reloadData()
                    return
                }
            }
        }else{
            alert(no_search.error_description!)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mycell")
        let article = self.articles[indexPath.row]
        
        cell.textLabel?.text = "\(String(article["title"]!!))"
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        table.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        let url_link = URL(string: article["url"]!!)                                                  //リポジトリが載っているurlを取得
        
        let safariViewController = SFSafariViewController(url: url_link!)                             //safariを開く処理
        safariViewController.delegate = true as? SFSafariViewControllerDelegate
        present(safariViewController,animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)                                                      //開いたsafariを閉じる処理
    }
    
    func alert(_ message : String){
        let ac = UIAlertController(title: "⚠️", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
}

