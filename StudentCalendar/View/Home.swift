import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    @State private var showingAddTaskView = false
    @State private var taskToEdit: Task? = nil
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(taskModel.currentWeek, id: \.self) { day in
                                    VStack(spacing: 10) {
                                        Text(taskModel.extractDate(from: day, format: "dd"))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        Text(taskModel.extractDate(from: day, format: "EEE"))
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 8, height: 8)
                                            .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                    }
                                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                    .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                    .frame(width: 45, height: 90)
                                    .background(
                                        ZStack {
                                            if taskModel.isToday(date: day) {
                                                Capsule()
                                                    .fill(Color.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        withAnimation {
                                            taskModel.currentDay = day
                                            taskModel.filterTodayTasks()
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        TasksView()
                    } header: {
                        HeaderView()
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .top)
            
            // Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        taskToEdit = nil // Reset to create new task
                        showingAddTaskView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                    .accessibilityLabel(Text("Add New Task"))
                }
            }
        }
        .sheet(isPresented: $showingAddTaskView) {
            AddTaskView(taskModel: taskModel, taskToEdit: taskToEdit)
        }
    }
    
    // MARK: Tasks View
    func TasksView() -> some View {
        LazyVStack(spacing: 20) {
            if let tasks = taskModel.filteredTasks {
                if tasks.isEmpty {
                    Text("No Tasks Found!")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    ForEach(tasks) { task in
                        TaskCardView(task: task)
                    }
                }
            } else {
                ProgressView().offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: taskModel.currentDay) { _ in
            taskModel.filterTodayTasks()
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(task.taskTitle)
                        .font(.headline)
                        .foregroundColor(.white)  // Text color set to white
                    
                    Text(task.taskDescription)
                        .font(.subheadline)
                        .foregroundColor(.white)  // Text color set to white
                    
                    HStack {
                        Text(task.startTime.formatted(date: .omitted, time: .shortened))
                        Text(" - ")
                        Text(task.endTime.formatted(date: .omitted, time: .shortened))
                    }
                    .font(.caption)
                    .foregroundColor(.white)  // Text color set to white
                }
                Spacer()
                HStack(spacing: 15) {
                    Button(action: {
                        taskToEdit = task
                        showingAddTaskView.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        taskModel.deleteTask(task: task)
                    }) {
                        Image(systemName: "trash")
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(15)
            .background(
                task.taskColor
                    .cornerRadius(15)
                    .shadow(radius: 5)
            )
        }
        .hLeading()
    }
    
    // MARK: Header
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                // Handle profile button tap
            } label: {
                Image("Profile1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// MARK: UI Design Helper Functions
extension View {
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: Safe Area
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

extension Color {
    var contrastColor: Color {
        guard let components = self.cgColor?.components else {
            return .black // Fallback color if components are not available
        }

        let red = components[0] * 299
        let green = (components.count > 1 ? components[1] : 0.0) * 587
        let blue = (components.count > 2 ? components[2] : 0.0) * 114

        let brightness = (red + green + blue) / 1000

        return brightness > 0.5 ? .black : .white
    }
}
