//
//  ECGTableViewCell.swift
//  Jeevan-Rekha
//
//

import UIKit

class ECGTableViewCell: UITableViewCell {

    @IBOutlet var View: UIView!
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
