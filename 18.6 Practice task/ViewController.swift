//
//  ViewController.swift
//  18.6 Practice task
//
//  Created by Alex Aytov on 4/24/23.
//

import SnapKit

class ViewController: UIViewController {
    
    private lazy var mainTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.backgroundColor = .gray
        return table
    }()
    
    private lazy var mainSearchBar: UISearchBar  = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "введите запрос..."
        return searchBar
    }()
    
    private lazy var aboutInfo: UILabel = {
        let label = UILabel()
        label.text = "Cервис для получения информации о фильмах, сериалах и актерском составе"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        return view
    }()

    private func setupViews() {
        view.addSubview(mainTableView)
        view.addSubview(mainSearchBar)
        view.addSubview(aboutInfo)
        mainSearchBar.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        aboutInfo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(mainSearchBar.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        mainSearchBar.snp.makeConstraints { make in
            make.bottom.equalTo(mainTableView.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        mainTableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(mainSearchBar.searchTextField.snp.leading).inset(17)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(MainCustomTVC.self, forCellReuseIdentifier: MainCustomTVC.identifier)
        setupViews()
        setupConstraints()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: MainCustomTVC.identifier) as! MainCustomTVC
        return reuseCell
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        activityIndicator.startAnimating()
        mainSearchBar.searchTextField.leftView?.isHidden = true
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        searchBar.showsCancelButton = false
        searchBar.text = ""
        activityIndicator.stopAnimating()
        mainSearchBar.searchTextField.leftView?.isHidden = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}
