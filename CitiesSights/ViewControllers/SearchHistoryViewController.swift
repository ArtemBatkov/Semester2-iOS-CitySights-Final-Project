//
//  SearchHistoryViewController.swift
//  CitiesSights
//
//  Created by user233573 on 4/5/23.
//

import UIKit

protocol ReturnHistoryRecordDelegate{
    func returnHistoryRecord(name: String)
}


class SearchHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var historyDelegate: ReturnHistoryRecordDelegate?
    
    private let _showPolygones = false;
    
    private let SearchBar = UISearchBar()
    private let stackView = UIStackView()
    private let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the Page
        SetUpPage()
        
        //Set delegates and Dsource to the table
        table.dataSource = self
        table.delegate = self
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        SearchBar.delegate = self
        
        //DEBUG MODE ONLY
        //FillFakeHistory()
        FilteredHistory = HistoryListModel.getHistoryList()
    }
    
    private func FillFakeHistory(){
        HistoryListModel.addToHistoryList(new: HistoryModel(_historyName: "Moscow"))
        HistoryListModel.addToHistoryList(new: HistoryModel(_historyName: "Rostov-on-Don"))
        HistoryListModel.addToHistoryList(new:    HistoryModel(_historyName: "Rostov"))
        HistoryListModel.addToHistoryList(new:   HistoryModel(_historyName: "Morokko"))
        HistoryListModel.addToHistoryList(new:    HistoryModel(_historyName: "Rostislav"))
        HistoryListModel.addToHistoryList(new:   HistoryModel(_historyName: "Sudbury"))
        HistoryListModel.addToHistoryList(new:   HistoryModel(_historyName: "Toronto"))
        HistoryListModel.addToHistoryList(new:    HistoryModel(_historyName: "Tokyo"))
        HistoryListModel.addToHistoryList(new:    HistoryModel(_historyName: "Vancouver"))
        HistoryListModel.addToHistoryList(new:    HistoryModel(_historyName: "Vladimir"))
        FilteredHistory = HistoryListModel.getHistoryList()
    }
    
    
    private var FilteredHistory = [HistoryModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FilteredHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = FilteredHistory[indexPath.row].getHistoryName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = FilteredHistory[indexPath.row].getHistoryName()
        print("selected: \(name)")
        if (name != nil){
            historyDelegate?.returnHistoryRecord(name: name)
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    //S----------------SEARCH-------------------//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var content = searchText
        if(content.isEmpty){
            FilteredHistory = HistoryListModel.getHistoryList()
        }else{
            FilteredHistory = HistoryListModel.getHistoryList().filter ({ $0.getHistoryName().lowercased().contains(content.lowercased()) })
        }
        table.reloadData()
    }
    
    //E----------------SEARCH-------------------//
    
    
    //Page Setuping
    private func SetUpPage(){
        //stack adj
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
        
        //UISearch adjust
        stackView.addSubview(SearchBar)
        SearchBar.placeholder = "Find a city in your history"
        SearchBar.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2).isActive = true
        SearchBar.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        SearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            SearchBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            SearchBar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            SearchBar.topAnchor.constraint(equalTo: stackView.topAnchor),
            SearchBar.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        stackView.addSubview(table)
        table.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8).isActive = true
        table.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            table.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
        //DEBUG MODE
        if(_showPolygones){
            stackView.backgroundColor = .red;
            table.backgroundColor = .yellow
            SearchBar.barStyle = .default
            SearchBar.barTintColor = .cyan
        }
    }
    
}
