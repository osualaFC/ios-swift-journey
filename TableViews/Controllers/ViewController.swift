//
//  ViewController.swift
//  TableViews
//
//  Created by fredrick osuala on 17/04/2021.
//

import UIKit

class LibraryViewController: UITableViewController {
    
    let books = Library.books
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @IBSegueAction func showBookDetails(_ coder: NSCoder) -> DetailsViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else {fatalError("Nothing selected")}
        let book = books[indexPath.row - 1]
        return DetailsViewController(coder: coder, book: book)
    }
    
    // MARK:- Data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell else {fatalError("Error")}
        let book = books[indexPath.row - 1]
        cell.title.text = book.title
        cell.author.text = book.author
        cell.thumbnail.image = book.image
        cell.thumbnail.layer.cornerRadius = 12
        return cell
    }

}

