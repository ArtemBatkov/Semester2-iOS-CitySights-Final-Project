//
//  CityModel.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import Foundation

struct CityModel: Decodable {
    var CityName: String
    var CityLat: String = String("0")
    var CityLon: String = String("0")
    var CityListSightes: [Sight]?
    var CityCountry : String
    
    var CityGooglePlaceId: String?
    var CityGooglePlacePhotoReferences: [String?] = []
    var CityGooglePlacePhotoData: [Data?] = []
    
    enum CodingKeys: String, CodingKey{
        case CityName = "name"
        case CityLat = "lat"
        case CityLon = "lon"
        case CityCountry = "country"
     }
    
    
    
}

extension CityModel{
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        CityLat = String(try container.decode(Double.self, forKey: .CityLat)) ?? "0"
        CityLon = String(try container.decode(Double.self, forKey: .CityLon)) ?? "0"
        CityName = try container.decode(String.self, forKey: .CityName)
        CityCountry = try container.decode(String.self, forKey: .CityCountry)
    }
}
