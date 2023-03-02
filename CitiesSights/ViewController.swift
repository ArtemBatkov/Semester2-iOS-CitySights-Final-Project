//
//  ViewController.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var CityTextField: UITextField!
    
    @IBOutlet weak var Button1_CityInfo: UIButton!
    
    
    @IBOutlet weak var Button2_SightsInfo: UIButton!
    
    @IBOutlet weak var CountryCodeTextField: UITextField!
    
    @IBOutlet weak var Button3_DetailedSightesInfo: UIButton!
    
    public var MyCity: CityModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func Button1_CityInfo(_ sender: Any){
        Task{
            await Button1_Click()
        }
    }
    
    private func Button1_Click() async {
        let name = CityTextField.text;
        let code = CountryCodeTextField.text;
        var url = "https://api.opentripmap.com/0.1/en/places/geoname?name=\(name!)&country=\(code!)&apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a".lowercased()
        do{
            Task{
                var data = try! await ClientService().fetchData(uri:url)
                var json = try! JSONSerialization.jsonObject(with: data)
                print(json)
                
                let City = try! JSONDecoder().decode(CityModel.self,from: data)
                MyCity = City
            }
        }catch{
            print(error)
        }
    }
    
    
    
    private let APIKEY = "5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a"
    
    @IBAction func Button2_SightsInfo(_ sender: Any) {
        Task{
            await Button2_Click()
        }
    }
    
    private func Button2_Click() async {
        var lat = MyCity!.CityLat
        var lon = MyCity!.CityLon
        var radius = 30*1000 // 30km or 30,000m
        var url = "https://api.opentripmap.com/0.1/en/places/radius?radius=\(radius)&lon=\(lon)&lat=\(lat)&apikey=\(APIKEY)".lowercased()
        do{
            Task{
                var data = try! await ClientService().fetchData(uri: url)
                var json = try! JSONSerialization.jsonObject(with: data)
                print(json)
                sights = try! JSONDecoder().decode(SightCollection.self,from: data)
                
            }
        }catch{
            print(error)
        }
    }
    
    private var sights: SightCollection?
    
    @IBAction func Button3_DetailedSightesInfo(_ sender: Any){
        //----------------MULTIPLE-TEST----------------//
            var attempts = 0
            sights?.features.forEach({ sight in
            var xid = sight.properties.xid
            var url = "https://api.opentripmap.com/0.1/en/places/xid/\(xid)?apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a"
            do{
                var task = Task{
                    var data = try! await ClientService().fetchData(uri: url)
                    var json = try! JSONSerialization.jsonObject(with: data)
                    print(json)
                    let mysight = try! JSONDecoder().decode(Sight.self, from: data)
                    attempts += 1
                    print("attempt #\(attempts)")
                    print(mysight.name)
                    
                    if(attempts % 9 == 0 ){
                        print("delay start")
                        sleep(60)
                        print("delay end")
                    }
                }
                
            }catch{
                print(error)
                print("attempt #\(attempts) fired the error")
            }
        })
            
        
        
        //----------------MULTIPLE-TEST----------------//
        
        
        
        
        //----------------UNIT-TEST---------------------//
//        let xid = "N1473999382" //"Q4092958"
//        var url = "https://api.opentripmap.com/0.1/en/places/xid/\(xid)?apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a"
//        do{
//            Task{
//                var data = try! await ClientService().fetchData(uri: url)
//                var json = try! JSONSerialization.jsonObject(with: data)
//                print(json)
//                let sight = try! JSONDecoder().decode(Sight.self, from: data)
//            }
//        }catch{
//            print(error)
//        }
        
        //----------------UNIT-TEST---------------------//
    }
    
    
    private func DelayThread(sec: Double) async {
        try! await Task.sleep(nanoseconds: UInt64(sec * Double(NSEC_PER_SEC)))
    }
    
}

