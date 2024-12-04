//
//  WineCell.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 4.12.2024.
//

import UIKit

class WineCell: UITableViewCell {

    @IBOutlet weak var wineImage: UIImageView!
    @IBOutlet weak var wineName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name : String , image : UIImage){
        self.wineName.text = name
        self.wineImage.image = image
    }
    
}
