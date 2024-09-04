//
//  Task.swift
//  StudentCalendar
//
//  Created by Benjamin Belloeil on 8/28/24.
//

import SwiftUI

// Task Model

struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var startTime: Date
    var endTime: Date
    var taskColor: Color
}
