import SwiftUI

class TaskViewModel: ObservableObject {

    // Your class schedule with corrected start and end times
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas III 306",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 26, hour: 11, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 26, hour: 15, minute: 0))!,
             taskColor: .pink),
             
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas IV 316",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 26, hour: 13, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 26, hour: 15, minute: 0))!,
             taskColor: .blue),
             
        Task(taskTitle: "Análisis y diseño de algoritmos avanzados",
             taskDescription: "Aulas IV 319",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 27, hour: 15, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 27, hour: 17, minute: 0))!,
             taskColor: .green),
             
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas III 306",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 27, hour: 11, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 27, hour: 15, minute: 0))!,
             taskColor: .pink),
             
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas IV 316",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 28, hour: 11, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 28, hour: 15, minute: 0))!,
             taskColor: .blue),
             
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas III 306",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 28, hour: 11, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 28, hour: 15, minute: 0))!,
             taskColor: .pink),
             
        Task(taskTitle: "Análisis y diseño de algoritmos avanzados",
             taskDescription: "Aulas IV 319",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 30, hour: 15, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 30, hour: 17, minute: 0))!,
             taskColor: .green),
             
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas III 306",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 29, hour: 11, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 29, hour: 15, minute: 0))!,
             taskColor: .pink),
             
        Task(taskTitle: "Integración de seguridad informática en redes y sistemas de software",
             taskDescription: "Aulas IV 316",
             startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 29, hour: 13, minute: 0))!,
             endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 29, hour: 15, minute: 0))!,
             taskColor: .blue)
    ]
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]?

    // MARK: Initializing
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    // MARK: Filter Today Tasks
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            // Normalize currentDay to remove the time component
            let startOfDay = calendar.startOfDay(for: self.currentDay)
            
            let filtered = self.storedTasks.filter {
                let taskDay = calendar.startOfDay(for: $0.startTime)
                return taskDay == startOfDay
            }
            .sorted { $0.startTime < $1.startTime }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        // Find the start of the current week
        if let week = calendar.dateInterval(of: .weekOfMonth, for: today) {
            let firstWeekDay = week.start
            
            // Populate the currentWeek array with the dates for each day of the week
            (0..<7).forEach { day in
                if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                    currentWeek.append(weekday)
                }
            }
        }
    }
    
    // MARK: Extracting Date
    func extractDate(from date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // MARK: Checking if current date is today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        return hour == currentHour
    }

    // MARK: Adding a new task
    func addTask(task: Task) {
        storedTasks.append(task)
        filterTodayTasks()
    }

    // MARK: Editing an existing task
    func editTask(task: Task) {
        if let index = storedTasks.firstIndex(where: { $0.id == task.id }) {
            storedTasks[index] = task
            filterTodayTasks()
        }
    }

    // MARK: Deleting an existing task
    func deleteTask(task: Task) {
        if let index = storedTasks.firstIndex(where: { $0.id == task.id }) {
            storedTasks.remove(at: index)
            filterTodayTasks()
        }
    }
}
