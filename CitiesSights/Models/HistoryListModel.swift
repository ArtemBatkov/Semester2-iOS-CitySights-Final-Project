//
//  HistoryListModel.swift
//  CitiesSights
//
//  Created by user233573 on 4/5/23.
//

import Foundation
import UIKit
import CoreData

class HistoryListModel{
    private static var _searchedCities  = [HistoryModel]()
    
    public static func getHistoryList()->[HistoryModel]{
        
        return _searchedCities;
    }
    
    public static func addToHistoryList(new history: HistoryModel){
        _searchedCities.insert(history, at: 0)
        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "HistoryModel", in: context)!
//        let newHistory = NSManagedObject(entity: entity, insertInto: context)
//
//        do {
//            let historyData = try NSKeyedArchiver.archivedData(withRootObject: history, requiringSecureCoding: false)
//            newHistory.setValue(historyData, forKey: "historyAsData")
//            try context.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }

    }

    public static func removeFromHistoryList(remove history:HistoryModel){
        _searchedCities.removeAll(where: {$0.getHistoryId() == history.getHistoryId()})
    }
    
    
    public static func loadToHistory(load history: HistoryModel){
        _searchedCities.insert(history, at: 0)
    }
}


