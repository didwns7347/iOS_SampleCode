//
//  UIButton.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/04/25.
//

import UIKit

extension UIButton{
    func adjustVerticalLayout(_ spacing:CGFloat = 0){
        let imagesize = self.imageView?.frame.size ?? .zero
        let titleLabelSize = self.titleLabel?.frame.size ?? .zero
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imagesize.width, bottom: -(imagesize.height + spacing), right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -(imagesize.height + spacing), left: 0, bottom: 0, right: -titleLabelSize.width)
    }
}
