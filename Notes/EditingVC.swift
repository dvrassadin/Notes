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
            self.title = "Edit note"
            textView.text = notes[index]
        } else {
            self.title = "New note"
            textView.becomeFirstResponder()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(resizeTextView(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resizeTextView(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Resize TextView when keyboard opens.
    @objc func resizeTextView(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
            textView.verticalScrollIndicatorInsets = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            textView.contentInset = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: keyboardFrame.height,
                                                 right: 0)
            textView.verticalScrollIndicatorInsets = textView.contentInset
        }
    }
    
    
    // MARK: - Navigation
    
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
