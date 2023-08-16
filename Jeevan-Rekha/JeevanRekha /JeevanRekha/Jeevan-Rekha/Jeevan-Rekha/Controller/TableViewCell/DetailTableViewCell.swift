//
//  DetailTableViewCell.swift
//  Jeevan-Rekha
//
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var View: UIView!
    @IBOutlet var suffering: UILabel!
    @IBOutlet var DOJ: UILabel!
    @IBOutlet var LastCheckDt: UILabel!
    @IBOutlet var LastCheckTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.View.layer.cornerRadius = 10
        selectionStyle = .none
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
