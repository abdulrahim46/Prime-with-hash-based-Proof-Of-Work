//
//  DataStoreTableViewCell.swift
//  Yaar
//
//  Created by Abdul Rahim on 01/05/21.
//

import UIKit

class DataStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var authToken: UITextField!
    @IBOutlet weak var fetchData: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
