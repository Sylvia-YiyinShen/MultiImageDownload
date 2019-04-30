//
//  ViewController.swift
//  MultiImageDownloadingDemo
//
//  Created by Yiyin Shen on 29/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 700
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "ListViewCell", bundle: .main), forCellReuseIdentifier: "ListViewCell")
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath)
        if let listCell = cell as? ListViewCell, let cellViewModel = viewModel.cellViewModel(at: indexPath.row) {
            listCell.configure(with: cellViewModel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Further improvement: suspend downloading task when cell is not in view
        print("didEndDisplaying row: \(indexPath.row)")
    }
}

