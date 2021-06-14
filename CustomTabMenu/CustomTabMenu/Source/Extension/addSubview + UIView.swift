//
//  addSubview + UIView.swift
//  CustomTabMenu
//
//  Created by 윤예지 on 2021/06/15.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews (_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
