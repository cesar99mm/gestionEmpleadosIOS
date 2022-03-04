//
//  EmpleadoCell.swift
//  empresa
//
//  Created by Cesar Martinez on 4/3/22.
//


import UIKit

class EmpleadoCell: UITableViewCell {

    
    @IBOutlet weak var nombreCampo: UILabel!
    @IBOutlet weak var salarioCampo: UILabel!
    @IBOutlet weak var puestoCampo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
