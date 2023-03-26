//
//  SightService.swift
//  CitiesSights
//
//  Created by user233573 on 3/25/23.
//

import Foundation

class SightService{
    private let _apikey = "AIzaSyDX9V4YhTFseL8gwoeWTszaLzf8y_Nw-nI"
    
    enum WebClientErros: Error{
        case PlaceIdNotFound;
        case URLProblems;
    }
    
    //https://developers.google.com/maps/documentation/places/web-service/autocomplete
    public func getPlaceId(for sight: Sight) async -> String{
        print(#function)
        
        let uri = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(sight.name)&key=\(_apikey)" //&types=(cities) between name and key
        do{
            var data = try! await ClientService().fetchData(uri: uri)
            var json = try! JSONSerialization.jsonObject(with: data) as? [String:Any]
            
            let predictions = json!["predictions"] as? [[String:Any]]
            
            print(json)
            print(predictions)
            var place_id = ""
            
            
            if (predictions!.count > 0)
            {
                place_id = predictions![0]["place_id"] as! String
                var description = predictions![0]["description"] as! String
                debugPrint(description)
            }
            else{
                place_id = ""
            }
            debugPrint(place_id)
            return place_id
        }
        catch{
            print(error)
        }
    }
    
    private func SearchMatching(sight:Sight)async->[String]{
        var findBy = ""
        var by = ""
        if(sight.name.isEmpty){
            findBy = sight.name
            by = "name"
        }
        else{
            if (sight.address != nil){
                var suburb = sight.address?.suburb
                var pedestrian = sight.address?.pedestrian
                var district = sight.address?.district
                if(district != nil){
                    findBy = district!
                    by = "district"
                }
                else if (pedestrian != nil){
                    findBy = pedestrian!
                    by = "pedestrian"
                }
                else if(suburb != nil){
                    findBy = suburb!
                    by = "suburb"
                }
                
               
            }
        }
        
        return [findBy, by]
    }
}
