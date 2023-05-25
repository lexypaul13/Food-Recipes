//
//  MealTableViewCell.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/24/23.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    static let identifier = "MealTableViewCell"
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mealImageView)
        addSubview(mealNameLabel)
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(mealImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with mealName: String?, mealImageURL: URL?) {
        mealNameLabel.text = mealName
        if let imageUrl = mealImageURL {
            mealImageView.loadImageUsingCache(withUrl: imageUrl)
        }
    }
    
}
