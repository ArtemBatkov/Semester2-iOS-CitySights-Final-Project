//
//  Sight.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import Foundation
/*
struct Sight: Decodable{
    var xid: String
    var SightName: String
    var SightLat: String
    var SightLon : String
    var SightKinds: String
    
    private var Features: String
    private var Geometry: [String]
    private var Proporties: String
    
    enum CodingKeys: String, CodingKey{
        case Features = "features"
        case Geometry = "geometry"
        case Proporties = "proporties"
     }
    
    
    
}
extension Sight{
    init(from decoder: Decoder) throws{
//        let unkeyed = try decoder.unkeyedContainer()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        print(decoder)
        Geometry = try container.decode([String].self, forKey: .Geometry)
        SightLon = String(try container.decode([Double.self][0], forKey: .Geometry)) ?? "0"
        SightLat = "0"
        SightName = "JOPA"
        SightKinds = "kind"
        xid = "0"
        Features = ")"
        Geometry = ["0"]
        Proporties = "0"
    }
}

struct SightResponse: Decodable, Hashable {
   
    //let features = [Sight]()
    let allInfo = [String]()
    enum CodingKeys: String, CodingKey{
        case features
        case type
        case id
        
        enum FeatureKey: String, CodingKey{
            case type
            case id
        }
    }
    
    
}

//https://api.opentripmap.com/0.1/en/places/radius?radius=30000&lon=30.31413&lat=59.93863&apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a


extension SightResponse{
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(String.self, forKey: .type)
        let log2 = values.contains(.features)
        let features = try values.decode([String: String].self, forKey: .features)
        let b = 3+3;
      
    }
}


*/
struct Sight: Codable {
    let xid: String?
    let name: String
    let address: Address?
    let rate, kinds: String
    let wikidata, wikipedia: String?
    let sources: Sources
    let otm: String
    let image: String?
    let preview: Preview?
    let wikipediaExtracts: WikipediaExtracts?
    let point: Point

    enum CodingKeys: String, CodingKey {
        case xid, name, address, rate, wikidata, kinds, sources, otm, wikipedia, image, preview
        case wikipediaExtracts = "wikipedia_extracts"
        case point
    }
    
    // MARK: - Address
    struct Address: Codable {
        let city, state: String?
        let road: String?
        let house, houseNumber: String?
        let country, postcode, countryCode: String?
        let stateDistrict: String?
        let suburb: String?
        let pedestrian: String?
        let district: String?

        enum CodingKeys: String, CodingKey {
            case city, road, house, state, country, postcode, pedestrian, district
            case countryCode = "country_code"
            case houseNumber = "house_number"
            case stateDistrict = "state_district"
            case suburb = "suburb"
        }
    }
    
    // MARK: - Point
    struct Point: Codable {
        let lon, lat: Double
    }

    // MARK: - Preview
    struct Preview: Codable {
        let source: String
        let height, width: Int
    }

    // MARK: - Sources
    struct Sources: Codable {
        let geometry: String
        let attributes: [String]
    }

    // MARK: - WikipediaExtracts
    struct WikipediaExtracts: Codable {
        let title, text, html: String
    }
    
}








struct SightCollection: Codable {
    let type: String
    let features: [Feature]
    
    struct Feature: Codable {
        let type: String
        let id: String
        let geometry: Geometry
        let properties: Properties
    }

    struct Geometry: Codable {
        let type: String
        let coordinates: [Double]
    }

    struct Properties: Codable {
        let xid: String
        let name: String
        let dist: Double
        let rate: Int
        let osm: String?
        let kinds: String
    }
    
}


