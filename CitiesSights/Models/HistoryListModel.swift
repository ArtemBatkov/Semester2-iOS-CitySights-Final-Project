//
//  HistoryListModel.swift
//  CitiesSights
//
//  Created by user233573 on 4/5/23.
//

import Foundation

class HistoryListModel{
    private static var _searchedCities  = [HistoryModel]()
    
    public static func getHistoryList()->[HistoryModel]{
        
        return _searchedCities;
    }
    
    public static func addToHistoryList(new history: HistoryModel){
        _searchedCities.insert(history, at: 0)
    }

    public static func removeFromHistoryList(remove history:HistoryModel){
        _searchedCities.removeAll(where: {$0.getHistoryId() == history.getHistoryId()})
    }
    
}


