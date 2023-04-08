//
//  DetailedSightPageViewController.swift
//  CitiesSights
//
//  Created by user233573 on 3/26/23.
//

import UIKit
import MapKit

class DetailedSightPageViewController: UIViewController {
    
    public var City: CityModel?
    
    public var ImageURL = ""
    public let ImageDefault = UIImage(named: "sight_blank")
    
    
    private var scrollView: UIScrollView = UIScrollView()
    private var stackView: UIStackView = UIStackView()
    
    //S------------SIGHTS-PROPORTIES------------//
    private var SightPhoto: UIImageView = UIImageView()
    private var _imageURL = "";
    
    private var SightTitle: UILabel = UILabel()
    public var Title: String = ""
    private var _title: String = ""
    
    private var FavouriteButton = UIButton(type: .custom)
    
    private var SightDescription = UILabel()
    public var Description = ""
    public var _description = ""
    
    
    private let SightMap = MKMapView()
    public var Lat: Double = 0
    public var Lon:Double = 0
    private var _lat: Double = 0
    private var _lon:Double = 0
    
    //E------------SIGHTS-PROPORTIES------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Build the page
        Task{
            await BuildThePage()
        }
    }
    
    private func InitializeImage() async{
        if(_imageURL.isEmpty){
            SightPhoto = UIImageView(image: ImageDefault!)
            
        }
        else{
            let data = try! await ClientService().fetchData(uri:_imageURL)
            let photo = UIImage(data: data) ?? ImageDefault!
            SightPhoto = UIImageView(image: photo)
        }
    }
    
    @objc func FavouriteButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(City != nil){
            TripList.addToTripList(new: City!)
        }
    }
    
    private func BuildThePage() async{
        scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
        ])
        //Make Some Title
        _title = Title
        SightTitle.text = _title
        SightTitle.textColor = .black
        SightTitle.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        SightTitle.minimumScaleFactor = 0.5
        SightTitle.textAlignment = .center
        stackView.addArrangedSubview(SightTitle)
        
        
        //Load Image
        _imageURL = ImageURL
        await InitializeImage()
        SightPhoto.backgroundColor = .green
        stackView.addArrangedSubview(SightPhoto)
//        SightPhoto.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
//        SightPhoto.heightAnchor.constraint(equalToConstant: 250).isActive = true
//        SightPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        SightPhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        SightPhoto.contentMode = .scaleAspectFit
//        SightPhoto.heightAnchor.constraint(equalToConstant: 250).isActive = true// задаем фиксированную высоту
//        SightPhoto.translatesAutoresizingMaskIntoConstraints = false
        SightPhoto.heightAnchor.constraint(equalToConstant: 250).isActive = true
        SightPhoto.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true

        
        
        //Add favourite button
        let rightStackView = UIStackView() //create a substackview
        rightStackView.axis = .vertical
        rightStackView.alignment = .trailing
        rightStackView.distribution = .fill
        //fav button creation
        FavouriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .selected)
        FavouriteButton.setImage(UIImage(systemName: "heart",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        FavouriteButton.tintColor = .red
        FavouriteButton.imageView?.contentMode = .scaleAspectFit
        FavouriteButton.imageView?.clipsToBounds = true
        FavouriteButton.imageView?.backgroundColor = .white
        FavouriteButton.imageView?.layer.cornerRadius = 10
        FavouriteButton.imageView?.layer.borderWidth = 1
        FavouriteButton.imageView?.layer.borderColor = UIColor.clear.cgColor
        FavouriteButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        FavouriteButton.isSelected = false
        FavouriteButton.addTarget(self, action: #selector(FavouriteButtonTapped), for: .touchUpInside)
        // renderingMode
        FavouriteButton.setImage(FavouriteButton.image(for: .selected)?.withRenderingMode(.alwaysTemplate), for: .selected)
        FavouriteButton.setImage(FavouriteButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        //add to subview
        rightStackView.addArrangedSubview(FavouriteButton)
        stackView.addArrangedSubview(rightStackView)
        
        
        //description
        _description = Description
        SightDescription.text = _description
        SightDescription.textColor = .black
        SightDescription.font = UIFont.systemFont(ofSize: 20)
        SightDescription.numberOfLines = 0
        SightDescription.lineBreakMode = .byWordWrapping
        //SightDescription.translatesAutoresizingMaskIntoConstraints = false
        SightDescription.textAlignment = .justified
        stackView.addArrangedSubview(SightDescription)
        
        //map
        _lat = Lat; _lon = Lon
        let location = CLLocationCoordinate2D(latitude: _lat, longitude: _lon)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        SightMap.setRegion(region, animated: false)
        //annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: _lat, longitude: _lon)
        annotation.title = _title
        SightMap.addAnnotation(annotation)
        
        SightMap.translatesAutoresizingMaskIntoConstraints = false
        SightMap.widthAnchor.constraint(equalToConstant: 250).isActive = true
        SightMap.heightAnchor.constraint(equalToConstant: 250).isActive = true

        stackView.addArrangedSubview(SightMap)
        

        
    }
    
    
    
    
}
