//
//  ViewController.swift
//  RealmSample
//
//  Created by Hank.Lee on 19/06/2019.
//  Copyright © 2019 hyeongkyu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    lazy var menus: [Menu] = [
        Menu(title: "Create", action: { [weak self] in
            let viewController = FormViewController(nibName: "\(FormViewController.self)", bundle: nil)
            let navigationController = UINavigationController(rootViewController: viewController)
            self?.present(navigationController, animated: true, completion: nil)
        }),
        Menu(title: "List", action: { [weak self] in
            let viewController = ListTableViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }),
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menus[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menus[indexPath.row].action?()
    }
    
    class Menu {
        let title: String
        let action: (() -> Void)?
        
        init(title: String, action: (() -> Void)?) {
            self.title = title
            self.action = action
        }
    }
}
