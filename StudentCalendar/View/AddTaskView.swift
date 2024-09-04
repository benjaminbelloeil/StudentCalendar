import SwiftUI

// ViewModel class remains the same

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var taskColor: Color = .blue
    
    @ObservedObject var taskModel: TaskViewModel
    var taskToEdit: Task? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Class Details").font(.headline)) {
                    TextField("Title", text: $taskTitle)
                        .font(.system(size: 18))
                    TextField("Description", text: $taskDescription)
                        .font(.system(size: 16))
                }
                
                Section(header: Text("Time").font(.headline)) {
                    DatePicker("Start Time", selection: $startTime, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("End Time", selection: $endTime, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section(header: Text("Color").font(.headline)) {
                    ColorPicker("Class Color", selection: $taskColor)
                }
                
                Section {
                    Button(action: {
                        if let taskToEdit = taskToEdit {
                            // Edit the existing task
                            var updatedTask = taskToEdit
                            updatedTask.taskTitle = taskTitle
                            updatedTask.taskDescription = taskDescription
                            updatedTask.startTime = startTime
                            updatedTask.endTime = endTime
                            updatedTask.taskColor = taskColor
                            taskModel.editTask(task: updatedTask)
                        } else {
                            // Add the new task
                            let newTask = Task(
                                taskTitle: taskTitle,
                                taskDescription: taskDescription,
                                startTime: startTime,
                                endTime: endTime,
                                taskColor: taskColor
                            )
                            taskModel.addTask(task: newTask)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(taskToEdit == nil ? "Add Class" : "Save Changes")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle(taskTitle.isEmpty ? "New Class" : taskTitle)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                if let taskToEdit = taskToEdit {
                    taskTitle = taskToEdit.taskTitle
                    taskDescription = taskToEdit.taskDescription
                    startTime = taskToEdit.startTime
                    endTime = taskToEdit.endTime
                    taskColor = taskToEdit.taskColor
                }
            }
        }
    }
}
