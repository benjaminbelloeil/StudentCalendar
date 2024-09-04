
//
//  StudentProfile.swift
//  StudentCalendar
//
//  Created by Developer on 8/29/24.
//

import SwiftUI

struct StudentProfile: View {
    @AppStorage("studentName") var studentName: String = ""
    @AppStorage("studentID") var studentID: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Student Information")) {
                    TextField("Name", text: $studentName)
                    TextField("Student ID", text: $studentID)
                        .keyboardType(.numberPad)
                }

                Section {
                    Button(action: {
                        // Action for saving profile information, if needed
                    }) {
                        Text("Save Profile")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct StudentProfile_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfile()
    }
}
