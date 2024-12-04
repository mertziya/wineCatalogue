//
//  WineViewModel.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 3.12.2024.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum WineType : String{
    case reds = "reds"
    case whites = "whites"
    case sparkling = "sparkling"
    case rose = "rose"
}

class WineViewModel{
    
    var publishedWines : PublishSubject<[Wine]> = PublishSubject()
    
    private var allWines: [Wine] = [] // stores all the json data that is fetched by using the api.
                                      // stores the data through Strings so the data is not bulk.
    private var updatedWines = [Wine]()
    
    var isLoading = false // to check that if the data is being loaded or not.
    
    func loadWines(type : WineType){
        AF.request("https://api.sampleapis.com/wines/\(type)", method: .get).responseDecodable(of: [Wine].self) { dataResponse in
            
            switch dataResponse.result{
            case .failure(let error):
                print(error.localizedDescription , " : WineViewModel")
                
            case .success(let data):
                self.allWines.append(contentsOf: data)
                self.getWines(amount: 10)
            }
        }
        
    }
    
    func getWines(amount : Int){ // Called to update the number of wines that are inside the observed variable.
        
        DispatchQueue.global().async{
            let startIndex = self.updatedWines.count
            let endIndex = self.updatedWines.count + amount - 1
            let subArrayOfWine = self.allWines[startIndex...endIndex]
            self.updatedWines.append(contentsOf: subArrayOfWine)
            self.publishedWines.onNext(self.updatedWines)
        }
    }
    
}
