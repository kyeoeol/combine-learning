//
//  ViewController.swift
//  CombineNetworkingWithTableView
//
//  Created by kyeoeol on 2022/07/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var cancellable: AnyCancellable?
    
    
    // MARK: - Properties
    
    private var service: NetworkServiceFetchable = NetworkService()
    private var posts: [Post] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        
        self.cancellable = self.service.getPosts()
            .catch { _ in
                return Just(self.posts)
            }
            .assign(to: \.posts, on: self)
    }
    
    
    // MARK: - UI
    
    @IBOutlet weak var tableView: UITableView!
    
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        let post = self.posts[indexPath.row]
        cell.textLabel?.text = post.title
        
        return cell
    }
    
}
