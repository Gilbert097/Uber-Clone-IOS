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
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    private lazy var logoutButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            title: "Deslogar",
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }()
    
    private var list: [RaceViewModel]?
    public var load: (() -> Void)?
    public var start: (() -> Void)?
    public var stop: (() -> Void)?
    public var logout: (() -> Void)?
    public var didRaceSelected: ((RaceViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.load?()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.start?()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stop?()
    }
    
    deinit {
        self.stop?()
    }
    
    @objc private func logoutButtonTapped() {
        self.logout?()
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
    
    func setupAdditionalConfiguration() {
        self.title = "Requisições"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = self.logoutButtonItem
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
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = list?[indexPath.row].displayText
        cell.detailTextLabel?.text = list?[indexPath.row].distanceText
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DriverListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let raceSelected = list?[indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        self.didRaceSelected?(raceSelected)
    }
}

//MARK: - RefreshListView
extension DriverListViewController: RefreshListView {
    
    public func refreshList(list: [RaceViewModel]) {
        self.list = list
        self.tableView.reloadData()
    }
}
