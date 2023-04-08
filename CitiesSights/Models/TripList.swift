//
//  TripList.swift
//  CitiesSights
//
//  Created by user233573 on 4/8/23.
//

import Foundation

class TripList{
    private static var _trips = [CityModel]()
    
    public static func getTripList()->[CityModel]{
        return _trips
    }
    
    public static func addToTripList(new city: CityModel){
        _trips.insert(city, at: 0)
    }       
}
