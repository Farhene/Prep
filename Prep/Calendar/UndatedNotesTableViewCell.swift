//
//  UndatedNotesTableViewCell.swift
//  Prep
//
//  Created by Farhene Sultana on 11/22/21.
//

import UIKit

class UndatedNotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bodyNotes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
