//
//  BankCell.swift
//  Challenge
//
//  Created by RicrdoRS on 4/29/20.
//  Copyright © 2020 Desarrollador1. All rights reserved.
//

import UIKit

protocol BankCellDelegate {
    func openUrl(url: String)
}

class BankCell: UITableViewCell {
    @IBOutlet weak var lblName          : UILabel!
    @IBOutlet weak var lblDescription   : UILabel!
    @IBOutlet weak var lblUrl           : UILabel!{
        didSet{
            lblUrl.isUserInteractionEnabled = true
            lblUrl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUrl)))
        }
    }
    @IBOutlet weak var lblAge           : UILabel!
    var delegate                        : BankCellDelegate?
    var url                             : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc private func openUrl(){
        delegate?.openUrl(url: url ?? "")
    }

}
