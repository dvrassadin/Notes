//
//  EditingVC.swift
//  Notes
//
//  Created by Daniil Rassadin on 16/3/23.
//

import UIKit

class EditingVC: UIViewController {
    
    var index: Int?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index {
            textView.text = notes[index]
            self.title = "Edit note"
        } else {
            self.title = "New note"
        }
        
        textView.becomeFirstResponder()
    }
    
    
    // MARK: - Navigation
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     */
    
    @IBAction func doneButton(_ sender: Any) {
        if let index {
            editNote(in: &notes, index: index, newNote: textView.text, key: .notes)
        } else if textView.text != "" {
            addNote(to: &notes, note: textView.text, key: .notes)
        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NotesVC") {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: false)
        }
    }
}
