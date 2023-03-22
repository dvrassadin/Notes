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
    
    /// Resize the TextView when the keyboard opens.
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
    
    func goToNotesVC() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NotesVC") {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: false)
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if let index {
            editNote(in: &notes, index: index, newNote: textView.text, key: .notes)
        } else if textView.text != "" {
            addNote(to: &notes, note: textView.text, key: .notes)
        }
        
        goToNotesVC()
    }
    
    @IBAction func backButton(_ sender: Any) {
        func createAlert(index: Int? = self.index) {
            let alertController = UIAlertController(title: nil, message: "Do you want to save the changes?", preferredStyle: .alert)
            let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { _ in
                self.goToNotesVC()
            }
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                self.goToNotesVC()
                if let index {
                    if self.textView.text == "" {
                        deleteNote(in: &notes, at: index, key: .notes)
                    } else {
                        editNote(in: &notes, index: index, newNote: self.textView.text, key: .notes)
                    }
                } else {
                    addNote(to: &notes, note: self.textView.text, key: .notes)
                }
            }
            alertController.addAction(discardAction)
            alertController.addAction(saveAction)
            present(alertController, animated: true)
        }
        
        if let index {
            self.textView.text == notes[index] ? goToNotesVC() : createAlert()
        } else {
            self.textView.text == "" ? goToNotesVC() : createAlert()
        }
        
//        let alertControllet = UIAlertController(title: nil, message: "Do you want to save the changes?", preferredStyle: .alert)
//        let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { _ in
//            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesVC") {
//                self.navigationController?.pushViewController(vc, animated: true)
//                vc.navigationItem.setHidesBackButton(true, animated: false)
//            }
//        }
//        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//            if let index = self.index {
//                if notes[index] != self.textView.text {
//                    editNote(in: &notes, index: index, newNote: self.textView.text, key: .notes)
//                }
//            } else if self.textView.text != "" {
//                addNote(to: &notes, note: self.textView.text, key: .notes)
//            }
//            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesVC") {
//                self.navigationController?.pushViewController(vc, animated: true)
//                vc.navigationItem.setHidesBackButton(true, animated: false)
//            }
//        }
//        alertControllet.addAction(discardAction)
//        alertControllet.addAction(saveAction)
//        present(alertControllet, animated: true)
//
    }
    
}
