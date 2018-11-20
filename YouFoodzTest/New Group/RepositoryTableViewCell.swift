//
//  RepositoryTableViewCell.swift
//  YouFoodzTest
//
//  Created by Andrew Napier on 20/11/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblRepoName: UILabel!
    @IBOutlet weak var lblForkedIndicator: UILabel!
    @IBOutlet weak var lblStargazerCount: UILabel!
    @IBOutlet weak var lblRepoAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureUsing(viewModel model : RepositoryModelFacade) {
        lblRepoName.text = model.name
        lblForkedIndicator.text = "Fork: \(model.isFork ? "Y" : "N")"
        lblStargazerCount.text = "Stargazers: \(model.stargazers)"
        lblRepoAge.text = "Age: \(model.getAge())"
    }
    
}
