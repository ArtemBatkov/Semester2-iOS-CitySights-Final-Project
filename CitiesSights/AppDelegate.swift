//
//  AppDelegate.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UIScrollViewDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        lazy var persistentContainer: NSPersistentContainer = {
//            let container = NSPersistentContainer(name: "HistoryModel")
//            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//                if let error = error as NSError? {
//                    fatalError("Unresolved error \(error), \(error.userInfo)")
//                }
//            })
//            return container
//        }()
//
//        LoadTheHistory()
        
        
//        Task{
//            try! await FillFakeData()
//        }
        return true
    }
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
//    func LoadTheHistory(){
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let request = NSFetchRequest<HistoryModel>(entityName: "HistoryModel")
//        do {
//            let historyItems = try context.fetch(request)
//            // здесь можно использовать полученный массив и делать с ним, что нужно
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//
//    }
//
    
    
    
    private func FillFakeData()async throws{
        let code = "ru"
        let names = ["Moscow","Rostov-on-Don","Krasnodar"]
        for name in names {
            var url = "https://api.opentripmap.com/0.1/en/places/geoname?name=\(name)&country=\(code)&apikey=5ae2e3f221c38a28845f05b62f0092f270a88190119b3678a057dd4a".lowercased()
            var data = try! await ClientService().fetchData(uri:url)
            var json = try! JSONSerialization.jsonObject(with: data) as? [String:Any]
            if(json?["status"] as! String != "OK"){
                throw WebClientErros.PageNotFound;
            }
            var City = try! JSONDecoder().decode(CityModel.self,from: data)
            
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CitiesSights")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

