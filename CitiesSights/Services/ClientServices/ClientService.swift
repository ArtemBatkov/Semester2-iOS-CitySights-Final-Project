//
//  ClientService.swift
//  CitiesSights
//
//  Created by user233573 on 2/13/23.
//

import Foundation

enum WebClientErros: Error{
    case PageNotFound;
    case URLProblems;
}


class ClientService{
    /*
     This class is used to retrieve raw data by passed urls.
     */       
    
    public func fetchData(uri: String) async throws -> Data{
        let encodedURL = uri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard
            var url = URL(string: encodedURL!)
        else{
            print(uri)
            throw WebClientErros.URLProblems
            
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        return data
    }
    
    
    
    
    
}
