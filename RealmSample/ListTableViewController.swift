//
//  ListTableViewController.swift
//  RealmSample
//
//  Created by Hank.Lee on 19/06/2019.
//  Copyright © 2019 hyeongkyu. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func item(index: Int) -> Shoe? {
        let realm = try! Realm()
        let item = realm.objects(Shoe.self)[index]
        return item
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Shoe.self).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let item = self.item(index: indexPath.row)
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = "\(item?.color ?? "no color"), \(item?.size ?? 0)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = FormViewController(nibName: "\(FormViewController.self)", bundle: nil)
        viewController.item = item(index: indexPath.row)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
}
