//
//  NotesVC.swift
//  Notes
//
//  Created by Daniil Rassadin on 16/3/23.
//

import UIKit

class NotesVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = notes[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete the note?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete Note", style: .destructive) { _ in
                deleteNote(in: &notes, at: indexPath.row, key: .notes)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? EditingVC {
            nextVC.index = tableView.indexPathForSelectedRow?.row
        }
    }

}
