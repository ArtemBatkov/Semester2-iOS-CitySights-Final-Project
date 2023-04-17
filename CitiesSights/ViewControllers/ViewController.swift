//
//  ViewController.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCountryCodeTapped))
        CountryCodeTextField.addGestureRecognizer(tapGesture)
        
        
        
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
        
        
        codePicker.delegate = self
        codePicker.dataSource = self
        
        codePicker.isHidden = true
        
        view.addSubview(codePicker)
        codePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            codePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            codePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            codePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            CountryCodeTextField.leadingAnchor.constraint(equalTo: CityTextField.leadingAnchor),
//            CountryCodeTextField.trailingAnchor.constraint(equalTo: CityTextField.trailingAnchor),
//            CountryCodeTextField.topAnchor.constraint(equalTo: CityTextField.topAnchor),
//            CountryCodeTextField.widthAnchor.constraint(equalTo: CityTextField.widthAnchor),


        ])
        
        codePicker.backgroundColor = .lightGray
        codePicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    
    
    @objc func onCountryCodeTapped(){
        codePicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        codeList.count
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CountryCodeTextField?.text = codeList[row]
        codePicker.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return codeList[row]
    }
    
    
    private let codePicker = UIPickerView()
    private let codeList = ["AUTO", "AF", "AX", "AL", "DZ", "AS", "AD", "AO", "AI", "AQ", "AG", "AR", "AM", "AW", "AU", "AT", "AZ", "BH", "BS", "BD", "BB", "BY", "BE", "BZ", "BJ", "BM", "BT", "BO", "BQ", "BA", "BW", "BV", "BR", "IO", "BN", "BG", "BF", "BI", "KH", "CM", "CA", "CV", "KY", "CF", "TD", "CL", "CN", "CX", "CC", "CO", "KM", "CG", "CD", "CK", "CR", "CI", "HR", "CU", "CW", "CY", "CZ", "DK", "DJ", "DM", "DO", "EC", "EG", "SV", "GQ", "ER", "EE", "ET", "FK", "FO", "FJ", "FI", "FR", "GF", "PF", "TF", "GA", "GM", "GE", "DE", "GH", "GI", "GR", "GL", "GD", "GP", "GU", "GT", "GG", "GN", "GW", "GY", "HT", "HM", "VA", "HN", "HK", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IM", "IL", "IT", "JM", "JP", "JE", "JO", "KZ", "KE", "KI", "KP", "KR", "KW", "KG", "LA", "LV", "LB", "LS", "LR", "LY", "LI", "LT", "LU", "MO", "MK", "MG", "MW", "MY", "MV", "ML", "MT", "MH", "MQ", "MR", "MU", "YT", "MX", "FM", "MD", "MC", "MN", "ME", "MS", "MA", "MZ", "MM", "NA", "NR", "NP", "NL", "NC", "NZ", "NI", "NE", "NG", "NU", "NF", "MP", "NO", "OM", "PK", "PW", "PS", "PA", "PG", "PY", "PE", "PH", "PN", "PL", "PT", "PR", "QA", "RE", "RO", "RU", "RW", "BL", "SH", "KN", "LC", "MF", "PM", "VC", "WS", "SM", "ST", "SA", "SN", "RS", "SC", "SL", "SG", "SX", "SK", "SI", "SB", "SO", "ZA", "GS", "SS", "ES", "LK", "SD", "SR", "SJ", "SZ", "SE", "CH", "SY", "TW", "TJ", "TZ", "TH", "TL", "TG", "TK", "TO", "TT", "TN", "TR", "TM", "TC", "TV", "UG", "UA", "AE", "GB", "US", "UM", "UY", "UZ", "VU", "VE", "VN", "VG", "VI", "WF", "EH", "YE", "ZM", "ZW"]
                            
  
    
    
    
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
            if(code == "AUTO"){
                url = "https://api.opentripmap.com/0.1/en/places/geoname?name=\(name!)&apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a".lowercased()
            }
            
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
    
    
    @IBAction func onTestPageClicked(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "TestPageViewController") as? TestPageViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
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

