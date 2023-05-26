//
//  ListViewController.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/23/23.
//
import UIKit
import SnapKit

class ListViewController: UIViewController, UITableViewDelegate {
    
    private let tableView = UITableView()
    private let viewModel = MealListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dessert List"
        navigationItem.largeTitleDisplayMode = .never
        setUpNavigationBarApperance()
        setupTableView()
        fetchMeals()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
    }
    
    private func fetchMeals() {
        viewModel.fetchMeals { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch meals: \(error)")
            }
        }
    }
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell() 
        }
        let mealName =  viewModel.mealName(at: indexPath.row)
        let mealImage = viewModel.mealImageURL(at: indexPath.row)
        cell.configure(with: mealName, mealImageURL: mealImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let mealID = viewModel.mealID(at: indexPath.row)
        
        let detailListVC = DetailListViewController()
        detailListVC.mealID = mealID
        self.navigationController?.pushViewController(detailListVC, animated: true)
    }
    
}
