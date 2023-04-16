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
        //if the same city has already existed in the list
        if let index = _trips.firstIndex(where: { $0.CityName == city.CityName }) {
            return
        }
        else{
            _trips.insert(city, at: 0)
        }
    }
    
    public static func updateProperties(city: CityModel){
        if let index = _trips.firstIndex(where: { $0.CityName == city.CityName }) {
            _trips[index] = city
        }
    }
    
    public static func updateFavouritePlaces(city: CityModel, index: Int){
        //if the city has already exists in the list, just update its favourites places
    }
    
    public static func existInTripList(name: String) -> Bool{
        return _trips.contains(where: { $0.CityName == name})
    }
    
    public static func getCitybyName(name: String)->CityModel?{
        if let index = _trips.firstIndex(where: { $0.CityName == name}) {
            return _trips[index]
        }
        else{
            return nil
        }
    }
}
