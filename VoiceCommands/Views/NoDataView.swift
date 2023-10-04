//
//  NoDataView.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
import UIKit
class NoDataView: UIView{
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var content: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    func commonInit(){
        Bundle.main.loadNibNamed("NoDataView", owner: self)
        self.addSubview(content)
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.loadUI()
    }
    func loadUI(){
        self.titleLabel.text = "no_data_title".localized()
        self.subtitleLabel.text = "no_data_subtitle".localized()
    }
}
