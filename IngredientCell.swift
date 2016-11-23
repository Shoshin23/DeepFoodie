//
//  IngredientCell.swift
//  DeepFoodie
//
//  Created by Karthik Kannan on 23/11/16.
//  Copyright © 2016 Karthik Kannan. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell,UITextFieldDelegate {
    let leftMarginForLabel: CGFloat = 15.0
    var label = UITextField()
    
    
    var ingredient:String? {
        didSet {
            label.text = ingredient
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        

        // 1
        label = UITextField(frame: CGRect.null)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 2
        label.delegate = self
        label.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        // 3
        addSubview(label)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: leftMarginForLabel, y: 0, width: bounds.size.width - leftMarginForLabel, height: bounds.size.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        ingredient = textField.text!
        print("Ingredient from tablecell:\(ingredient)")
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
