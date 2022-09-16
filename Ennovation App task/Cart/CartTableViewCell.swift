//
//  CartTableViewCell.swift
//  Ennovation App task
//
//  Created by Shiv on 16/09/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
