//
//  CommandActionCell.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
import UIKit
class CommandActionCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jsonDescription: UILabel!

    @IBOutlet weak var valueLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
