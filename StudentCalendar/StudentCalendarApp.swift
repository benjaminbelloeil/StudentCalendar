//
//  StudentCalendarApp.swift
//  StudentCalendar
//
//  Created by Benjamin Belloeil on 8/28/24.
//

import SwiftUI

@main
struct StudentCalendarApp: App {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskModel) // Pass the task model to all child views
        }
    }
}
