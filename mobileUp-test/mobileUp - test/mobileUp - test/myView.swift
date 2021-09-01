//
//  myView.swift
//  mobileUp - test
//
//  Created by Роман Зобнин on 28.07.2021.
//

import UIKit

class myView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit(){
        Bundle.main.loadNibNamed("myView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView .autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
