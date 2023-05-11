//
//  DriverListViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import UIKit

public class DriverListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    private var list: [RaceViewModel]?
    public var load: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Requisições"
        self.view.backgroundColor = .white
        setupView()
        self.load?()
    }
}

// MARK: - ViewCode
extension DriverListViewController: ViewCode {
    func setupViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension DriverListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list?[indexPath.row].email
        return cell
    }
}

//MARK: - RefreshListView
extension DriverListViewController: RefreshListView {
    
    public func refreshList(list: [RaceViewModel]) {
        self.list = list
        self.tableView.reloadData()
    }
}
