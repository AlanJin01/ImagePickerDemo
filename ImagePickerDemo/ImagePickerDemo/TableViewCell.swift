//
//  TableViewCell.swift
//  ImagePickerDemo
//
//  Created by J K on 2019/1/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var imgView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
