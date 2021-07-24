//
//  newClass.swift
//  kdhbslkbdsfk
//
//  Created by Роман Зобнин on 01.02.2021.
//

import UIKit

 class CustomButtonClass: UIView {
   
   var weight = 100
   var collor = UIColor.red
   
   private let button = UIButton()
   
   
   var isSetuped = false
   override func layoutSubviews() {
       super.layoutSubviews()
       
       button.backgroundColor = collor
       button.frame.size.width = CGFloat(weight)
       button.frame = CGRect(x: 0, y: 0, width: weight, height: 80)
       
       if isSetuped {return}
       isSetuped = true
       addSubview(button)
   }
   
}
