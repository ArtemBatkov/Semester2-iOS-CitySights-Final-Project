//
//  TripViewController.swift
//  CitiesSights
//
//  Created by user233573 on 4/8/23.
//

import UIKit

class TripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let stackView = UIStackView()
    private let table = UITableView()
    
    private let _showPolygones = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        let nib = UINib(nibName: "TripTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TripTableViewCell")
        SetUpPage()
    }
    
    //S----------Table--------------//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TripList.getTripList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "TripTableViewCell", for: indexPath) as! TripTableViewCell
        let name = TripList.getTripList()[indexPath.row].CityName
        debugPrint(name)
        //cell.Title.text = name
        cell.title = name
        let photos = TripList.getTripList()[indexPath.row].CityGooglePlacePhotoData
        if photos != nil && !photos.isEmpty{
            cell.avatar = photos[0]
            //cell.Avatar = UIImageView(image: UIImage(data: photos[0]!))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TripTableViewCell {
            print(cell.title) // обращаемся к свойству title ячейки
            if let avatar = cell.avatar {
                debugPrint(avatar) // обращаемся к свойству avatar ячейки
                debugPrint(String(data: avatar, encoding: .utf8))
            }
            debugPrint(cell.Avatar.image)
        }
    }

    
    //E----------Table--------------//
    
    
    
    
    
    
    //Setting Up the page
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
        
        stackView.addSubview(table)
        table.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1).isActive = true
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
        }
    }

}
