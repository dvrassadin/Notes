//
//  Model.swift
//  Notes
//
//  Created by Daniil Rassadin on 16/3/23.
//

import Foundation

var notes: [String] = ["First note", "Another one very biiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiig note", "And one more", "Very big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big  note"]

func addNote(to array: inout [String], note: String) {
    array.insert(note, at: 0)
    saveData()
}

func deleteNote(in array: inout [String], at index: Int) {
    array.remove(at: index)
    saveData()
}

func editNote(in array: inout [String], index: Int, newNote: String) {
    array[index] = newNote
    saveData()
}

func loadData() {
    
}

func saveData() {
    
}
