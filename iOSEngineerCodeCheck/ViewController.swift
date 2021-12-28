//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var firstPresentor: FirstPresentor!
        
    @IBOutlet weak var searchBar: UISearchBar!
    var repositories: [[String: Any]]=[]
    
    var URLSessionTask: URLSessionTask?
    var searchedWord: String?
    var repositoryURL: String?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        self.firstPresentor.tableView.delegate = self
        self.firstPresentor.tableView.dataSource = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // サーチバーテキストを初期化する。
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //URLSessionTask?.cancel()
        firstPresentor.URLSessionTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else{return}
        searchedWord = searchBarText
        
        if searchedWord?.count == 0 {return}
        firstPresentor.searchRepository(searchedWord: searchedWord ?? "non")
        repositories = firstPresentor.repositories
        reloadTableView()
        // リストを更新する。
        //URLSessionTask?.resume()
        firstPresentor.URLSessionTask?.resume()
    }
    func reloadTableView(){
            self.firstPresentor.tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            if let nextView = segue.destination as? ViewController2 {
                nextView.mainViewController = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return firstPresentor.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let repository = firstPresentor.repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されらcellの番号を参照する。
        index = indexPath.row
        //画面遷移時に呼ばれる。
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
