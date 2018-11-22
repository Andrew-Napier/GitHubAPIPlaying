//
//  MainView.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import UIKit
import SafariServices

class MainView: UITableViewController {
    let comms = Comms()
    let listBuilder : ListBuilderProtocol = DataPersistLayer(ListBuilder())
    let reuseIdentifier = "RepositoryTableViewCell"

        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Establish tableview cells...
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle:nil),
                           forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88

        // Establish listeners...
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataHasRefreshed(_:)),
                                               name: ListBuilder.dataUpdated,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataFailedRefresh(_:)),
                                               name: ListBuilder.dataError,
                                               object: nil)
        
        // Initiate comms...
        refresh()

        self.title = "YouFoodz Repo Viewer"
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .refresh,
                            target: self,
                            action: #selector(refresh))
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        let persist = listBuilder as? DataPersistanceProtocol
        persist?.save()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBuilder.getRepositoryList().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? RepositoryTableViewCell
        
        assert(cell != nil, "Unable to dequeue the registered tableview cell.");

        let model = RepositoryModelFacade(listBuilder.getRepositoryList()[indexPath.row])
        cell?.configureUsing(viewModel: model)
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        assert(index >= 0 && index < listBuilder.getRepositoryList().count,
               "The tableView is telling us a non-backed row of the table was selected")
        
        let model = listBuilder.getRepositoryList()[index];
        tableView.deselectRow(at: indexPath, animated: true)

        guard let repoUrl = URL(string: model.repoUrl) else {
            return
        }
        
        launchSafariViewer(forUrl: repoUrl)
    }
    
    // MARK: - Notification handling
    
    @objc func dataHasRefreshed(_ notification : NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func dataFailedRefresh(_ notification : NSNotification) {
        DispatchQueue.main.async {
            guard let info = notification.userInfo else {
                // No user info, no error message, don't bother!
                return
            }
            let message = (info["Message"] as? String) ?? "An unknown error has occurred"
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: -
    
    @objc private func refresh() {
        comms.delegate = listBuilder as? CommsDelegate
        comms.makeRequest()
    }
    
    private func launchSafariViewer(forUrl url : URL) {
        let webBrowser = SFSafariViewController.init(url: url)
        self.present(webBrowser, animated: true, completion: nil)
    }

}
