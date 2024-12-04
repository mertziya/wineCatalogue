//
//  WineDetailsVC.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 4.12.2024.
//

import UIKit

class WineDetailsVC: UIViewController {
    let service = WebService()
    var selectedWine: Wine?
    
    
    
    @IBOutlet weak var ratingDescription: UILabel!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!

    @IBOutlet weak var wineImage: UIImageView!
    
    @IBOutlet weak var wineName: UILabel!
    
    @IBOutlet weak var winery: UILabel!
    @IBOutlet weak var location: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIElements()
    }
    
}





extension WineDetailsVC {
    
    func setUIElements(){
        if let safeSelectedWine = selectedWine{
            service.loadImage(imageUrlString: safeSelectedWine.image) { image in
                self.wineImage.image = image
            }
            self.wineName.text = safeSelectedWine.wine
            self.winery.text = safeSelectedWine.winery
            self.location.text = safeSelectedWine.location
            setRatingStars(rating: safeSelectedWine.rating)
        } else{
            print("optional error : WineDetailsVC")
        }
        
    }
    
    
    // star --> empty star (deffault)    star.leadinghalf.filled --> half star     star.fill --> full start
    func setRatingStars(rating: Rating){
        guard let ratingFloat = Float(rating.average) else {let ratingFloat = 0 ; return}
        self.ratingDescription.text = "\(rating.average) out of \(rating.reviews) reviews"
        
        let emptyStar = UIImage(systemName: "star")
        let halfStar = UIImage(systemName: "star.leadinghalf.filled")
        let fullStar = UIImage(systemName: "star.fill")
        
        if(ratingFloat < 0.25){ firstStar.image = emptyStar}
        if(ratingFloat > 0.25){ firstStar.image = halfStar}
        if(ratingFloat > 0.75){ firstStar.image = fullStar}
        if(ratingFloat > 1.25){ secondStar.image = halfStar}
        if(ratingFloat > 1.75){ secondStar.image = fullStar}
        if(ratingFloat > 2.25){ thirdStar.image = halfStar}
        if(ratingFloat > 2.75){ thirdStar.image = fullStar}
        if(ratingFloat > 3.25){ fourthStar.image = halfStar}
        if(ratingFloat > 3.75){ fourthStar.image = fullStar}
        if(ratingFloat > 4.25){ fifthStar.image = halfStar}
        if(ratingFloat >= 5)  { fifthStar.image = fullStar}
        
        
    }
}
