//
//  DetailViewController.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: class {
    func showDetails(userDetails: [String])
    func showLoading()
    func hideLoading()
    func selectedNameUpdater()
    func showNextScreenError()
}

class DetailViewController: UIViewController {

    let detailsPresenter: DetailsPresenterProtocol    
    let dismissButton: UIButton
    let loginButton: UIButton
    let namesLabel: UILabel
    let tableView: UITableView    

    init(detailsPresenter: DetailsPresenterProtocol) {
        self.detailsPresenter = detailsPresenter
        self.dismissButton = UIButton()
        self.dismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.dismissButton.setTitle("Dismiss", for: .normal)
        self.loginButton = UIButton()
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.setTitle("Loading...", for: .normal)
        self.namesLabel = UILabel()
        self.namesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.namesLabel.textColor = .white
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false                
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        self.namesLabel.numberOfLines = 0
        self.namesLabel.text = self.detailsPresenter.selectedName
        self.view.addSubview(dismissButton)
        self.view.addSubview(loginButton)
        self.view.addSubview(namesLabel)
        self.view.addSubview(tableView)
        self.dismissButton.addTarget(self, action: #selector(dismissDetails), for: .touchUpInside)
        self.loginButton.addTarget(self, action: #selector(moveToNextScreen), for: .touchUpInside)

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()

        let views = ["dismissButton": dismissButton, "loginButton": loginButton, "nameLabel": namesLabel, "tableView": tableView]

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dismissButton]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[loginButton]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nameLabel]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[dismissButton(44)]-[nameLabel(>=0)][tableView][loginButton(44)]-|", options: [], metrics: nil, views: views))
        self.detailsPresenter.presentDetails(user: self.detailsPresenter.user)
    }

    @objc private func moveToNextScreen() {
        self.detailsPresenter.moveToNextScreen()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func dismissDetails() {
        self.detailsPresenter.dismiss()
    }
}

extension DetailViewController: DetailViewProtocol {
    func showDetails(userDetails: [String]) {
        self.tableView.reloadData()
    }

    func showLoading() {
        self.loginButton.setTitle("Loading...", for: .normal)
    }

    func hideLoading() {
        self.loginButton.setTitle("Go to final Screen", for: .normal)
    }

    func selectedNameUpdater() {
        self.namesLabel.text = self.detailsPresenter.selectedName
    }

    func showNextScreenError() {
        print("Cannot move to next screen. Please select name to continue")
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailsPresenter.indexSelected(indexPath.row)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailsPresenter.userDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.detailsPresenter.userDetails[indexPath.row]
        return cell
    }
}
