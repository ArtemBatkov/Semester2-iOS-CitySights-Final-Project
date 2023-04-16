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
        
        
        //just for test
        var  favourites = [String: [Sight]]()
        for var city in TripList.getTripList(){
            favourites[city.CityName] = city.FavouriteSights
        }
        var b = 3;
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
        cell.TheCity = TripList.getTripList()[indexPath.row]
        let photo = TripList.getTripList()[indexPath.row].CityDefaultBackgroundData//TripList.getTripList()[indexPath.row].CityGooglePlacePhotoData
        if photo != nil{
            cell.avatar =  photo
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
            
            if let vc = storyboard?.instantiateViewController(identifier: "TripDetailedViewController") as? TripDetailedViewController{
                let city = cell.TheCity
                let controller = TripDetailedViewController()
                vc.BackImgData = cell.avatar
                vc.TheCity = city
                controller.tripDetailedDelegate = self
                vc.tripDetailedDelegate = controller.tripDetailedDelegate
                vc.detailedIndexPath = indexPath
                controller.updateCityDelegate = self
                vc.updateCityDelegate = controller.updateCityDelegate
                self.navigationController?.pushViewController(vc, animated: true)
            }
          

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
    
    private func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < table.numberOfSections && indexPath.row < table.numberOfRows(inSection: indexPath.section)
        }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if (CityMainPage == nil || updatedCity == nil){
//            navigationController?.popViewController(animated: true)
////            super.viewWillDisappear(animated)
//        }
//        else{
//            if(TripList.existInTripList(name: CityMainPage!.CityName)){
//                TripList.updateProperties(city: updatedCity!)
//                //replacing
//                CityMainPage = TripList.getCitybyName(name: updatedCity!.CityName)
//                updateCityDelegate?.updateTheCity(city: CityMainPage!)
//            }
//            else{
//                navigationController?.popViewController(animated: true)
//            }
//            super.viewWillDisappear(animated)
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(animated){
            var b = 3;
        }
        else{
            var b = 5;
        }
        guard let updatedCity = updatedCity, let mainPageCity = CityMainPage else {
                //navigationController?.popViewController(animated: true)
                return
        }
        if(TripList.existInTripList(name: CityMainPage!.CityName)){
            TripList.updateProperties(city: updatedCity)
            //replacing
            CityMainPage = TripList.getCitybyName(name: updatedCity.CityName)
            updateCityDelegate?.updateTheCity(city: CityMainPage!)
        }
        else{
            //navigationController?.popViewController(animated: true)
        }
       //navigationController?.popViewController(animated: true)
      
    }
    
    
    
    public var updateCityDelegate: UpdateTheCityDelegate?
    public var CityMainPage: CityModel?
    
    private var updatedCity: CityModel?
}



extension TripViewController: TripDetailedDelegate, UpdateTheCityDelegate{
    func updateTheCity(city: CityModel) {
        updatedCity = city
        TripList.updateProperties(city: city)
        var currentList = TripList.getTripList()
        self.table.reloadData()
    }
    
    func updateTablesRow(indexPath: [IndexPath]) {
        guard indexPath.allSatisfy({ indexPathIsValid($0) }) else {
            self.table.reloadData()
                    return
        }
        self.table.reloadRows(at: indexPath, with: .automatic)
    }
}
