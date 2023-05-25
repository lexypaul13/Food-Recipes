//
//  DetailListViewController.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/24/23.
//

import UIKit
import SnapKit

class DetailListViewController: UIViewController {
    
    
    private let tableView = UITableView()
    var viewModel = MealDetailListViewModel()
    var mealID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadMealDetails(for: mealID)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: InstructionsTableViewCell.identifier)
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    
    private func loadMealDetails(for mealID:String?) {
        guard let mealID = mealID else{
            return 
        }
        viewModel.fetchMealDetails(mealID: mealID) { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                print("Failed to load meal details")
            }
        }
    }
    
    
}

extension DetailListViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.ingredientCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
            headerView.backgroundColor = .lightGray
            
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 15, y: 0, width: headerView.bounds.width - 30, height: headerView.bounds.height)
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .white
            
            if section == 0 {
                titleLabel.text = "Instructions"
            } else if section == 1 {
                titleLabel.text = "Measurements"
            }
            
            headerView.addSubview(titleLabel)
            
            return headerView
        }

        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsTableViewCell.identifier, for: indexPath) as! InstructionsTableViewCell
            cell.configure(with: viewModel.strInstructions)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as! IngredientsTableViewCell
            let ingredientName = viewModel.ingredientName(at: indexPath.row)
            let ingredientMeasure = viewModel.ingredientMeasure(at: indexPath.row)
            cell.configure(with: ingredientName, measure: ingredientMeasure)
            return cell
        }
    }
    
    
}
