//
//  MainView.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import UIKit

class MainView: UITableViewController {
    let comms = Comms()
    let listBuilder = ListBuilder()
    let reuseIdentifier = "RepositoryTableViewCell"

        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Establish tableview cells...
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle:nil),
                           forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88

        // Establish listeners...
        NotificationCenter.default.addObserver(self, selector: #selector(dataHasRefreshed(_:)), name: ListBuilder.dataUpdated, object: nil)
        
        // Initiate comms...
        refresh()

        self.title = "YouFoodz Repo Viewer"
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .refresh,
                            target: self,
                            action: #selector(refresh))
    }

/* Side note: I prefer to use extensions (as per the ListBuilder) for implementing
   delegates and protocols, but didn't get there with this class
 */
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBuilder.repositoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? RepositoryTableViewCell
        
        if cell == nil {
            // TODO: Create a cell when it can't be dequeued. (memory blank!)
        }
        
        cell?.configureUsing(viewModel: listBuilder.repositoryList[indexPath.row])
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        assert(index >= 0 && index < listBuilder.repositoryList.count,
               "The tableView is telling us a non-backed row of the table was selected")
        
        let model = listBuilder.repositoryList[index];
        
        guard let repoUrl = URL(string: model.repoUrl) else {
            return
        }
        
        UIApplication.shared.open(repoUrl, options: [:]) { (success) in
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Notification handling
    
    @objc func dataHasRefreshed(_ notification : NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: -
    
    @objc private func refresh() {
        comms.delegate = listBuilder
        comms.makeRequest()
    }
    
}
