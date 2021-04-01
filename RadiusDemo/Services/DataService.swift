//
//  DataService.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    
    func getDataFromApi(completionHandler: @escaping (_ success: Bool, _ data:ResponseData?, _ error: String?)->()) {
        
        let session = URLSession.shared
        let url = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check the response
            print(response)
            
            // Check if an error occured
            if error != nil {
                // HERE you can manage the error
                print(error)
                completionHandler(false, nil, error?.localizedDescription)
                return
            }
            
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(ResponseData.self, from: data! )
                completionHandler(true, json, nil)
                //try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                completionHandler(false, nil, error.localizedDescription)
            }
            
        })
        task.resume()
    }
}
