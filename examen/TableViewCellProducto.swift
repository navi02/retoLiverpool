//
//  TableViewCellProducto.swift
//  examen
//
//  Created by nataly on 27/09/16.
//  Copyright © 2016 navi. All rights reserved.
//

import UIKit

class TableViewCellProducto: UITableViewCell {

    @IBOutlet weak var imagenProducto: UIImageView!
    
    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var desProducto: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
