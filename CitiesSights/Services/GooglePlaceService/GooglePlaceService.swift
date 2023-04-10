//
//  GooglePlaceService.swift
//  CitiesSights
//
//  Created by user233573 on 4/9/23.
//

import Foundation

enum GoogleErros: Error{
    case FilterError;
    case PhotoReferenceError;
}

class GooglePlayService{
    public let ErrorId = "ERROR_ID_NOT_FOUND"
    private let gkey = "AIzaSyDX9V4YhTFseL8gwoeWTszaLzf8y_Nw-nI"
    public let ErrorImage = "ERROR_IMAGE_NOT_FOUND"
    
    public func getGoogleCityID(find city: CityModel)async->String{
        let name = city.CityName
        let reg = city.CityCountry
        var id = ErrorId
        var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(name)&types=(cities)&language=en&components=country:\(reg)&key=\(gkey)"
        var data = try! await ClientService().fetchData(uri:url)
        var json = try! JSONSerialization.jsonObject(with: data) as? [String:Any]
        if(json?["status"] as! String != "OK") {
            return ErrorId
        }
        var predictions = json?["predictions"] as? [[String:Any]]
        var possibleIDs = [String]()
        for prediction in predictions ?? []{
            if let pid =     prediction["place_id"] as? String {
                possibleIDs.insert(pid, at: 0)
            }
        }
        debugPrint(possibleIDs.forEach {debugPrint($0)})
        debugPrint("total: \(possibleIDs.count) --------------------")
        if (possibleIDs.isEmpty){
            return ErrorId
        }
        else if (possibleIDs.count == 1){
            return possibleIDs[0]
        }
        else{
            id = try! await filterID(list: possibleIDs, city: city)
        }
        return id
    }
    
    public func getGooglePhotoCandidates(place id: String) async -> [String?]
    {
        var references = [String]()
        var url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(id)&fields=photo&key=\(gkey)"
        var data = try! await ClientService().fetchData(uri:url)
        var json = try! JSONSerialization.jsonObject(with: data) as? [String:Any]
        if (json?["status"] as? String != "OK") {
            return references
        }
        var result = json?["result"] as? [String:Any]
        var photos = result?["photos"] as? [[String: Any]]
        for photo in photos ?? []{
            if let reference = photo["photo_reference"] as? String, !reference.isEmpty {
                references.insert(reference, at: 0)
            }
        }
        references.forEach({debugPrint($0)})
        debugPrint("quantity: \(references.count) --------------------")
        return references
    }
    
    
    public func getGooglePhotoAsData(candidates list: [String?])async->[Data?]{
        var data = [Data?]()
        if(list.isEmpty || list == nil){return data}
        for item in list{
            var url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(item!)&sensor=false&key=\(gkey)"
            var d = try! await ClientService().fetchData(uri:url)
            if(d != nil){
                data.insert(d, at: 0)
            }            
        }
        return data
    }
    
    
    
    
    
    private func filterID(list ids: [String], city city: CityModel) async throws -> String {
        var id = ErrorId
        let name = city.CityName
        var Lat = city.CityLat
        var Lon = city.CityLon
        for placeid in ids {
            var url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeid)&fields=name,geometry&key=\(gkey)"
            var data = try! await ClientService().fetchData(uri:url)
            var json = try! JSONSerialization.jsonObject(with: data) as? [String:Any]
            if(json?["status"] as! String != "OK") {
                throw GoogleErros.FilterError;
            }
            var result = json?["result"] as? [String:Any]
            var geometry = result?["geometry"] as? [String:Any]
            var viewport = geometry?["viewport"] as? [String:Any]
            var northeast = viewport?["northeast"] as? [String:Any]
            var southwest = viewport?["southwest"] as? [String:Any]
            var nlon = northeast?["lng"] as! Double
            var nlat = northeast?["lat"] as! Double
            var slon = southwest?["lng"] as! Double
            var slat = southwest?["lat"] as! Double
            debugPrint("olon: \(Lon), olat: \(Lat), nlon: \(nlon), nlat: \(nlat); slon: \(slon), slat: \(slat)")
            if(IsBetween(original_lat: Double(Lat)! , original_lon: Double(Lon)!, north_lon: nlon, north_lat: nlat, south_lon: slon, south_lat: slat)){
              //if it is between it is a true id
                id = placeid
                return id
            }
        }
        return id
    }
    
    private func IsBetween(original_lat lat: Double, original_lon lon: Double,
                           north_lon nlon: Double, north_lat nlat: Double,
                           south_lon slon: Double, south_lat slat: Double) -> Bool{
        if (slat...nlat).contains(lat) && (slon...nlon).contains(lon) {
            return true;
        }
        else{
            return false;
        }
    }
    
}
