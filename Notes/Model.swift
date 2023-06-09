//
//  Model.swift
//  Notes
//
//  Created by Daniil Rassadin on 16/3/23.
//

import Foundation

var notes: [String] = ["Hello! The TextView should rise when you edit the note because this is a really big big  big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big big note!"]

enum UDKeys: String {
    case notes
}

func addNote(to array: inout [String], note: String, key: UDKeys) {
    array.insert(note, at: 0)
    saveData(array: array, key: key)
}

func deleteNote(in array: inout [String], at index: Int, key: UDKeys) {
    array.remove(at: index)
    saveData(array: array, key: key)
}

func editNote(in array: inout [String], index: Int, newNote: String, key: UDKeys) {
    array[index] = newNote
    saveData(array: array, key: key)
}

func loadData(array: inout [String], key: UDKeys) {
    if let data = UserDefaults.standard.array(forKey: key.rawValue) as? [String] {
        array = data
    }
}

func saveData(array: [String], key: UDKeys) {
    UserDefaults.standard.set(array, forKey: key.rawValue)
}
