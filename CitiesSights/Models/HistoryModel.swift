//
//  SearchModel.swift
//  CitiesSights
//
//  Created by user233573 on 4/5/23.
//

import Foundation

class HistoryModel{
    
    init(_historyName: String) {
        self._historyName = _historyName
        
        //Looking for unique Id
        var items = HistoryListModel.getHistoryList()
        var uniqueId = UUID().uuidString
        while (items.contains(where: {$0.getHistoryId() == uniqueId})) {
            uniqueId = UUID().uuidString
        }
        self._historyId = uniqueId
    }
    
    private var _historyId: String = ""
    public func getHistoryId()->String{
        return _historyId
    }
    
    private var _historyName = ""
    public func getHistoryName()->String{
        return _historyName
    }
    
    
    
}
