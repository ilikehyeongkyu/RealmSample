//
//  FormViewController.swift
//  RealmSample
//
//  Created by Hank.Lee on 19/06/2019.
//  Copyright © 2019 hyeongkyu. All rights reserved.
//

import UIKit
import RealmSwift

class FormViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        return deleteButton
    }()
    
    let labelTitles = ["Name", "Color", "Size"]
    
    var item: Shoe? {
        didSet {
            bind()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Form"
        setNavigationItems()
        
        labelTitles.forEach { (title) in
            guard let view = UINib(nibName: "\(FormItemView.self)", bundle: nil).instantiate(withOwner: nil, options: nil).first as? FormItemView else {
                return
            }
            view.label.text = title
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAnimated))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createOrUpdate))
    }
    
    @objc private func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
    private func formItemView(index: Int) -> FormItemView? {
        if index >= stackView.arrangedSubviews.count { return nil}
        return stackView.arrangedSubviews[index] as? FormItemView
    }
    
    @objc private func createOrUpdate() {
        if item != nil {
            update()
        } else {
            create()
        }
        
        dismissAnimated()
    }
    
    private func create() {
        let name = formItemView(index: 0)?.textField.text ?? ""
        let color = formItemView(index: 1)?.textField.text ?? ""
        let size = Int(formItemView(index: 2)?.textField.text ?? "") ?? 0
        let shoe = Shoe(name: name, color: color, size: size)
        
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(shoe)
        try! realm.commitWrite()
    }
    
    private func update() {
        guard let item = item else { return }
        let name = formItemView(index: 0)?.textField.text ?? ""
        let color = formItemView(index: 1)?.textField.text ?? ""
        let size = Int(formItemView(index: 2)?.textField.text ?? "") ?? 0
        
        let realm = try! Realm()
        realm.beginWrite()
        
        item.name = name
        item.color = color
        item.size = size
        
        try! realm.commitWrite()
    }
    
    @objc private func deleteItem() {
        guard let item = item else { return }
        let realm = try! Realm()
        realm.beginWrite()
        realm.delete(item)
        try! realm.commitWrite()
        dismissAnimated()
    }
    
    private func bind() {
        if !isViewLoaded { loadViewIfNeeded() }
        
        navigationItem.rightBarButtonItem?.title = item != nil ? "Update" : "Create"
        
        formItemView(index: 0)?.textField.text = item?.name
        formItemView(index: 1)?.textField.text = item?.color
        if let size = item?.size {
            formItemView(index: 2)?.textField.text = String(size)
        } else {
            formItemView(index: 2)?.textField.text = nil
        }
        
        if item != nil {
            stackView.addArrangedSubview(deleteButton)
        } else {
            stackView.removeArrangedSubview(deleteButton)
        }
    }
}
