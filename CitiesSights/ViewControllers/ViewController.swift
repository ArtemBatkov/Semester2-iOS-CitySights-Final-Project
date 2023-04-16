//
//  ViewController.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CityTextField: UITextField!
    
    
    @IBOutlet weak var CountryCodeTextField: UITextField!
    
    
    @IBOutlet weak var SearchCityButton: UIButton!
    
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var HistoryButton: UIBarButtonItem!
    
    
    
    
    
    public var footerView: UIView!
    public var loadMore: UIButton!
    public var MyCity: CityModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "SightCellTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "SightCellTableViewCell")
        table.delegate = self
        table.dataSource = self
        
        footerView =  UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        loadMore = UIButton()
        loadMore.frame = CGRect(x: view.frame.size.width/4, y: 10, width: view.frame.size.width/2, height: 50)
        loadMore.backgroundColor = UIColor.systemBlue
        loadMore.setTitle("Load more", for: .normal)
        loadMore.setTitleColor(UIColor.black, for: .normal)
        
        footerView.addSubview(loadMore)
        footerView.isHidden = true
        self.table.tableFooterView = footerView
        
        // loadMore.addTarget(self,
        //                action: #selector(LoadMore),
        //              for: .touchUpInside)
        
        loadMore.addTarget(self, action: #selector(self.LoadMore), for: .touchUpInside)
        
        //footerView.translatesAutoresizingMaskIntoConstraints = false
        //loadMore.translatesAutoresizingMaskIntoConstraints = false
        //table.tableFooterView?.translatesAutoresizingMaskIntoConstraints = false
        
        searchSpinner.color = .gray
        searchSpinner.tag = 777
        searchSpinner.hidesWhenStopped = true
        table.tableHeaderView = searchSpinner
        table.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
    }
    private let searchSpinner = UIActivityIndicatorView()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailedSightPageViewController") as? DetailedSightPageViewController{
            let controller = DetailedSightPageViewController()
            
            controller.updateCityDelegate = self
            vc.updateCityDelegate = controller.updateCityDelegate
            vc.City = self.MyCity
            
            
            let cell = Sights[indexPath.row]
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
    
    
    private func StartSubViewSpinner(){
        let spinner = UIActivityIndicatorView()
        spinner.center =  loadMore.titleLabel!.center
        loadMore.setTitle("", for: .normal)
        spinner.color = UIColor.white
        spinner.tag = 2611
        loadMore.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func EndSubViewSpinner(){
        if let view = loadMore.viewWithTag(2611){
            loadMore.setTitle("Load more", for: .normal)
            view.removeFromSuperview()
        }
    }
    
    private func StartSearchSpinner(){
        searchSpinner.startAnimating()
    }
    private func EndSearchSpinner(){
        searchSpinner.stopAnimating()
    }
    
    
    
    private var _start: Int = 0;
    private var _end:Int = 0;
    private var _defaultStep:Int = 7;
    
    @objc func LoadMore() {
        Task{
            do{
                print("\n"+#function)
                StartSubViewSpinner()
                var seconds = 2
                var start_ex = CFAbsoluteTimeGetCurrent()
                try! await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
                print("Delay takes: \(CFAbsoluteTimeGetCurrent()-start_ex)")
                _end = sights?.features.count ?? 0
                var step: Int = 0
                if(_end == _start){
                    print("The sight list ended")
                    print("Original count: \(sights?.features.count), actially count: \(Sights.count)")
                    EndSubViewSpinner()
                    loadMore.isHidden = true
                    return
                }
                //define the step
                if(_end - _start <= _defaultStep){
                    step = (_end - _start)
                }
                if(_end - _start > _defaultStep){
                    step = _defaultStep
                }
                //chunck the array
                if(sights?.features != nil){
                    print("[from = \(_start), to = \(_start+step), overall = \(_end)]")
                    var from = _start
                    var to = _start + step
                    //debugPrint(from, to)
                    var sliced = Array(sights!.features[from...to-1])
                    //debugPrint(sliced)
                    var newSights:[Sight] = try! await RequestChunk(list: sliced)
                    
                    Sights.append(contentsOf: newSights)
                    table.reloadData()
                    
                    if(searchSpinner.isAnimating){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.EndSearchSpinner()
                        }
                    }
                    
                    EndSubViewSpinner()
                    _start = to
                }
            }catch{
                print(error)
            }
        }
    }
    
    private func AddNewRecordToHistory(record: String){
        var history = HistoryModel(_historyName: record)
        HistoryListModel.addToHistoryList(new: history)
    }
    
    
    private func RequestChunk(list sliced: [SightCollection.Feature]) async -> [Sight]{
        var newFoundSights: [Sight] = [Sight]()
        for slice in sliced {
            var xid = slice.properties.xid
            var url = "https://api.opentripmap.com/0.1/en/places/xid/\(xid)?apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a"
            do{
                let data = try! await ClientService().fetchData(uri: url)
                var json = try! JSONSerialization.jsonObject(with: data)
                var mysight = try? JSONDecoder().decode(Sight.self, from: data)
                if(mysight != nil)
                {
                    //                    if(!mysight!.name.isEmpty){
                    //                        try! await SightService().getPlaceId(for: mysight!)
                    //                        newFoundSights.append(mysight!)
                    //                    }
                    newFoundSights.append(mysight!)
                    //debugPrint(mysight)
                }
            }catch{
                print(error)
            }
        }
        return  newFoundSights
    }
    
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(Sights.count == 0) {
            footerView.isHidden = true
            return;
        }
        
        let position = scrollView.contentOffset.y
        if(position>(table.contentSize.height-100-scrollView.frame.size.height)){
            footerView.isHidden = false
        }
        else{
            footerView.isHidden  = true
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sights.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "SightCellTableViewCell", for: indexPath) as! SightCellTableViewCell
        cell.ShortDescriptionSight.text = Sights[indexPath.row].name
        cell.TitleSight.text = Sights[indexPath.row].wikidata
        
        if(Sights[indexPath.row].preview?.source != nil){
            if(Sights[indexPath.row].preview!.source.isEmpty) {
                cell.ImageViewSight.image = UIImage(named: "sight_blank")
            }
            else{
                Task{
                    var xid = Sights[indexPath.row].xid
                    var url = Sights[indexPath.row].preview!.source
                    var data = try! await ClientService().fetchData(uri:url)
                    cell.ImageViewSight.image = UIImage(data: data)
                    if(cell.ImageViewSight.image == nil){
                        cell.ImageViewSight.image = UIImage(named: "sight_blank")
                    }
                    let str = String(decoding: data, as: UTF8.self)
                    debugPrint(str)
                    debugPrint(data)
                }
            }
        }
        else{
            cell.ImageViewSight.image = UIImage(named: "sight_blank")
        }
        
        return cell
    }
    
    
    
    private var Sights = [Sight]()
    
    
    
    
    @IBAction func onClickSearchCityButton(_ sender: Any) {
        Task{
            loadMore.isHidden = false
            Sights.removeAll()
            table.reloadData()
            print("Test 0")
            AddNewRecordToHistory(record: CityTextField.text!)
            StartSearchSpinner()
            print("Test1")
            try! await GetCityAsync()
            print("Test2")
            try! await GetSightsListAsync()
            
            print("Test3")
            //try! await GetSevenSightsAsync()
            try! await LoadMore()
            //table.reloadData()
            //print("Test4")
            
            
        }
    }
    
    
    
    
    private func GetCityAsync() async throws{
        print(#function)
        let name = CityTextField.text;
        let code = CountryCodeTextField.text;
        
        //decide do we have the same city in our TripList
        if(TripList.existInTripList(name: name!)){
            MyCity = TripList.getCitybyName(name: name!)
            var b = 3
        }
        else{
            var url = "https://api.opentripmap.com/0.1/en/places/geoname?name=\(name!)&country=\(code!)&apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a".lowercased()
            
            var data = try! await ClientService().fetchData(uri:url)
            var json = try! JSONSerialization.jsonObject(with: data) as? [String:Any]
            print(json)
            if(json?["status"] as! String != "OK"){
                throw WebClientErros.PageNotFound;
            }
            let City = try! JSONDecoder().decode(CityModel.self,from: data)
            MyCity = City
        }
    }
    
    
    private func GetSightsListAsync() async throws{
        print("\n"+#function)
        if MyCity?.CityLat == nil{
            return;
        }
        if (MyCity?.CityLon == nil){
            return;
        }
        var lat = MyCity!.CityLat
        var lon = MyCity!.CityLon
        var radius = 1000*30// 30km or 30,000m
        //        let url = "https://api.opentripmap.com/0.1/en/places/radius?radius=\(radius)&lon=\(lon)&lat=\(lat)&src_geom=wikidata&src_attr=wikidata&apikey=\(APIKEY)".lowercased()
        let url = "https://api.opentripmap.com/0.1/en/places/radius?radius=\(radius)&lon=\(lon)&lat=\(lat)&apikey=\(APIKEY)".lowercased()
        do{
            var data = try! await ClientService().fetchData(uri: url)
            var json = try! JSONSerialization.jsonObject(with: data)
            print(json)
            sights = try! JSONDecoder().decode(SightCollection.self,from: data)
            if let quantity = sights?.features.count{
                _end = quantity
                _start = 0
            }
            else{
                _end = 0
                _start = 0
            }
            
        }catch{
            print(error)
        }
    }
    
    
    
    @IBAction func onTripButtonClick(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "TripViewController") as? TripViewController{
            let controller = TripViewController()
            controller.updateCityDelegate = self
            vc.updateCityDelegate = controller.updateCityDelegate
            vc.CityMainPage = MyCity
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func onHistoryButtonClick(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "SearchHistoryViewController") as? SearchHistoryViewController{
            let controller = SearchHistoryViewController()
            controller.historyDelegate = self
            vc.historyDelegate = controller.historyDelegate
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    private let APIKEY = "5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a"
    private var sights: SightCollection?
    
}

extension ViewController: ReturnHistoryRecordDelegate{
    func returnHistoryRecord(name: String) {
        self.dismiss(animated: true){
            if(!name.isEmpty){
                self.CityTextField.text = name
            }
        }
    }
}

extension ViewController: UpdateTheCityDelegate{
    func updateTheCity(city: CityModel) {
        self.MyCity = city
        TripList.updateProperties(city: city)
    }
    
    
}

