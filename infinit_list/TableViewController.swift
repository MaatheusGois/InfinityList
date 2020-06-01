//
//  FirstViewController.swift
//  infinit_list
//
//  Created by Matheus Silva on 01/06/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var numberRows = 20
    var indexOfPageToRequest = 0
    var isLoading = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //Return the amount of items
            return numberRows
        } else {
            //Return the Loading cell
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
                cell.textLabel?.text = "Batata"
                return cell
            } else {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
                return cell
            }
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44 //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }

    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
                if let cell = self.tableView.cellForRow(at: .init(row: 0, section: 1)) {
                    cell.contentView.showSpinner()
                    loadMoreData()
                }
                
            }
        }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                // Download more data here
                DispatchQueue.main.async {
                    if self.numberRows <= 20 {
                       self.numberRows += 10
                    }
                    
                    self.tableView.reloadData {
                        if let cell = self.tableView.cellForRow(at: .init(row: 0, section: 1)) {
                            cell.contentView.removeSpinner()
                        }
                    }
                    self.isLoading = false
                }
            }
        }
    }
}

extension UITableView {
    func reloadData(completion :@escaping ()->Void) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
    }
}

