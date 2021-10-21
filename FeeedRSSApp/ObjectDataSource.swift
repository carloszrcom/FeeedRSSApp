//
//  ObjectDataSource.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 21/10/21.
//

import UIKit
import Foundation

class ObjectDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var posts = [Post]()
    
    // MARK: - Helpers
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tituloPost = posts[indexPath.row].titulo
        
        cell.textLabel?.text = tituloPost
        
        return cell
    }
}
