//
//  InstructionTableViewCell.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/24/23.
//

import UIKit

class InstructionsTableViewCell: UITableViewCell {
    static let identifier = "InstructionsTableViewCell"
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(instructionsLabel)
        instructionsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with instructions: String?) {
        guard let instructions = instructions else{
            return 
        }
        instructionsLabel.text = instructions
    }
}


