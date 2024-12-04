//
//  WebService.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 3.12.2024.
//

import Foundation
import UIKit

class WebService{
    
    func loadImage(imageUrlString: String , completion: @escaping (UIImage?) -> ()){
        guard let url = URL(string: imageUrlString) else{print("ERROR1 : WebService") ; return}
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error{
                print(error.localizedDescription , "Webservice")
                completion(UIImage())
            }else if let imageData = data {
                guard let image = UIImage(data: imageData) else{ let image = UIImage(named: "imageNotFound") ; return}
                DispatchQueue.main.async {
                    completion(image)
                }
            }else{
                print("ERROR 3 : WebService")
                completion(UIImage())
            }
        }.resume()
        
    }
    
}
