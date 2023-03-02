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
        guard
            var url = URL(string: uri)
        else{throw WebClientErros.URLProblems}
        let (data, response) = try await URLSession.shared.data(from: url)
        return data
    }
    
    
    public func fetchDataTimeLimit(uri:String, seconds timelimit: Double) async throws -> Data{
        guard
            var url = URL(string: uri)
        else{throw WebClientErros.URLProblems}
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timelimit
        
        let session = URLSession(configuration: sessionConfig)
        let (data, response) = try  await session.data(from: url)
        return data
    }
    
}
