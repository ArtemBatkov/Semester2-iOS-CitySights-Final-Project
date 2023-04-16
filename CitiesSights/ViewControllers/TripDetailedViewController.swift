//
//  TripDetailedViewController.swift
//  CitiesSights
//
//  Created by user233573 on 4/10/23.
//

import UIKit

protocol TripDetailedDelegate{
    func updateTablesRow(indexPath: [IndexPath])
}
 


class TripDetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    
    var tripDetailedDelegate: TripDetailedDelegate?
    var detailedIndexPath: IndexPath?
    
    private let stackView = UIStackView()
    private let Title = UILabel()
    //private let Image
    
    private let table = UITableView()
    
    public var BackImgData: Data?
    
    private let BackImgDefault = UIImage(named: "trip_blank")
    
    public var TheCity: CityModel?
    
    private var backgroundImage: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup the page
        PageSetUp()
        
        table.delegate  = self
        table.dataSource = self
        
        let nib = UINib(nibName: "SightCellTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "SightCellTableViewCell")
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TheCity!.FavouriteSights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "SightCellTableViewCell", for: indexPath) as! SightCellTableViewCell
        var favourites = TheCity!.FavouriteSights
        cell.ShortDescriptionSight.text = favourites[indexPath.row].name
        cell.TitleSight.text = favourites[indexPath.row].wikidata
        
        if(favourites[indexPath.row].preview?.source != nil){
            if(favourites[indexPath.row].preview!.source.isEmpty) {
                cell.ImageViewSight.image = UIImage(named: "sight_blank")
            }
            else{
                Task{
                    var xid = favourites[indexPath.row].xid
                    var url = favourites[indexPath.row].preview!.source
                    var data = try! await ClientService().fetchData(uri:url)
                    cell.ImageViewSight.image = UIImage(data: data)
                    if(cell.ImageViewSight.image == nil){
                        cell.ImageViewSight.image = UIImage(named: "sight_blank")
                    }
                }
            }
        }
        else{
            cell.ImageViewSight.image = UIImage(named: "sight_blank")
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailedSightPageViewController") as? DetailedSightPageViewController{
            let controller = DetailedSightPageViewController()
            controller.updateCityDelegate = self
            vc.updateCityDelegate = controller.updateCityDelegate
            vc.City = self.TheCity
            
            var favourites = TheCity?.FavouriteSights
            
            let cell = favourites![indexPath.row]
            
            if let imageURL = cell.preview?.source{
                vc.ImageURL = imageURL
            }
            vc.Title = cell.name
            vc.Sight = cell
            
            if let Description = cell.wikipediaExtracts?.text{
                vc.Description = Description
            }
            vc.Lon = cell.point.lon
            vc.Lat = cell.point.lat
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    
    @objc func editTapped() {
        if let vc = storyboard?.instantiateViewController(identifier: "EditTripDetailedPageViewController") as? EditTripDetailedPageViewController{
            let controller = EditTripDetailedPageViewController()
            controller.updateBackgroundDelegate = self
            vc.updateBackgroundDelegate = controller.updateBackgroundDelegate
            if(TheCity != nil){
                var setOfImages = TheCity!.CityGooglePlacePhotoData
                vc.imgData = TheCity!.CityGooglePlacePhotoData
                vc.ThisCity = TheCity
                if(BackImgData != nil){
                    setOfImages.forEach({ image in
                        if(image == BackImgData){
                            vc.selectedImage = UIImage(data: image!)
                            return
                        }
                    })
                }                
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
//        if(detailedIndexPath != nil){
//            tripDetailedDelegate?.updateTablesRow(indexPath: [detailedIndexPath!])
//        }else{
//            navigationController?.popViewController(animated: true)
//        }
        super.viewWillDisappear(animated)
        if (TheCity == nil) {DetailedPageErrors.CityIsNull}
        TheCity = TripList.getCitybyName(name: TheCity!.CityName)
            updateCityDelegate?.updateTheCity(city: TheCity!)
            
    }
    
    
    private func PageSetUp() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = editButton

        if BackImgData == nil {
            backgroundImage = UIImageView(image: UIImage(named: "trip_blank"))
        } else {
            backgroundImage = UIImageView(image: UIImage(data: BackImgData!))
        }
        backgroundImage.alpha = 0.55
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill

        //add some title
        let titleView = UIView()
        titleView.backgroundColor = .clear
        titleView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleView)
        titleView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2).isActive = true

        Title.text = TheCity?.CityName
        Title.numberOfLines = 1
        Title.textColor = .white
        Title.layer.shadowColor = UIColor.black.cgColor
        Title.layer.shadowOffset = CGSize(width: 0, height: 0)
        Title.layer.shadowRadius = 5.0
        Title.layer.shadowOpacity = 1.0
        Title.layer.masksToBounds = false
        Title.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        Title.minimumScaleFactor = 0.5
        Title.textAlignment = .center

        titleView.addSubview(Title)
        Title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Title.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            Title.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])

        //table setup
        table.backgroundColor = .clear
        table.separatorStyle = .none
        stackView.addArrangedSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            table.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8)
        ])

        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    public var updateCityDelegate: UpdateTheCityDelegate?
    
    
    
    

}
extension TripDetailedViewController: UpdateBackgroundAfterEditingDelegate, UpdateTheCityDelegate{
    func NewSelectedBackground(image: UIImage?){
        self.dismiss(animated: true){
            if image != nil{
                self.backgroundImage.image = image
            }
        }
    }
    
    
    func updateTheCity(city: CityModel) {
        self.dismiss(animated: true){
            self.TheCity = city
            self.table.reloadData()
        }
    }
    
    
}


 

