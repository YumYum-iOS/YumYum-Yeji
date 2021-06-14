//
//  tabMenuCollectionViewCell.swift
//  CustomTabMenu
//
//  Created by 윤예지 on 2021/06/15.
//

import UIKit

class tabMenuCollectionViewCell: UICollectionViewCell {
    var tabLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    
    func setStatus(name : String, isTouched : Bool)
    {
        tabLabel.textColor = isTouched ? .purple : .darkGray
        tabLabel.text = name
    }
         
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabLabel)
        
        tabLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.centerX.centerY.equalToSuperview()
        }
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
