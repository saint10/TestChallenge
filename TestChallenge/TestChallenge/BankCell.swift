//
//  BankCell.swift
//  Challenge
//
//  Created by RicrdoRS on 4/29/20.
//  Copyright © 2020 Desarrollador1. All rights reserved.
//

import UIKit

class BankCell: UITableViewCell {
    @IBOutlet weak var lblName          : UILabel!
    @IBOutlet weak var lblDescription   : UILabel!
    @IBOutlet weak var lblUrl           : UILabel!
    @IBOutlet weak var lblAge           : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
