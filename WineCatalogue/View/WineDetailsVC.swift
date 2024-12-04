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
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    

    @IBOutlet weak var wineImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.loadImage(imageUrlString: selectedWine!.image) { image in
            self.wineImage.image = image
        }
    }
    
}
