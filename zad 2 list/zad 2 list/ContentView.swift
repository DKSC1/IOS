import SwiftUI

enum TaskStatus {
    case notStarted, inProgress, completed
}

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let imageName: String?
    var status: TaskStatus = .notStarted
}

struct ContentView: View {
    @State private var tasks: [Task] = [
        Task(title: "Zrobić zakupy", description: "Kupić mleko, chleb i masło", imageName: "Zakupy", status: .notStarted),
        Task(title: "Posprzątać mieszkanie", description: "Odkurzyć i umyć podłogi", imageName: "Sprzatanie", status: .inProgress),
        Task(title: "Nauczyć się SwiftUI", description: "Przerobić podstawy i stworzyć mały projekt", imageName: nil, status: .completed)
    ]
    
    @State private var newTaskTitle: String = ""
    @State private var isAddingTask = false
    @State private var taskToDelete: Task?
    @State private var showConfirmationDialog = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        HStack {
                            // Pasek statusu
                            Rectangle()
                                .fill(statusColor(for: task.status))
                                .frame(width: 8)
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            if let imageName = task.imageName {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Rectangle())
                                    .padding(.trailing, 8)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                    .strikethrough(task.status == .completed, color: .gray)
                                if let description = task.description {
                                    Text(description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            // Przycisk zmiany stanu
                            Button(action: {
                                changeTaskStatus(task: task)
                            }) {
                                Image(systemName: "arrow.right.arrow.left.square.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .onDelete(perform: confirmDelete)
                    .onMove(perform: moveTask)
                }
                
                // Przycisk dodawania zadania
                Button(action: {
                    isAddingTask = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                        Text("Dodaj Zadanie")
                            .font(.headline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .navigationTitle("Lista Zadań")
            .toolbar {
                EditButton()
            }
            .alert("Czy na pewno chcesz usunąć to zadanie?", isPresented: $showConfirmationDialog) {
                Button("Usuń", role: .destructive, action: deleteTask)
                Button("Anuluj", role: .cancel) {}
            }
            .sheet(isPresented: $isAddingTask) {
                AddTaskView { title in
                    addTask(title: title)
                }
            }
        }
    }
    
    // Funkcja zwracająca kolor paska statusu
    private func statusColor(for status: TaskStatus) -> Color {
        switch status {
        case .notStarted: return .red
        case .inProgress: return .yellow
        case .completed: return .green
        }
    }
    
    // Funkcja zmiany stanu zadania
    private func changeTaskStatus(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            switch tasks[index].status {
            case .notStarted:
                tasks[index].status = .inProgress
            case .inProgress:
                tasks[index].status = .completed
            case .completed:
                tasks[index].status = .notStarted
            }
        }
    }
    
    // Funkcja dodawania nowego zadania
    private func addTask(title: String) {
        let newTask = Task(title: title, description: nil, imageName: nil, status: .notStarted)
        tasks.append(newTask)
    }
    
    // Funkcja zmiany kolejności zadań
    private func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    // Funkcja wywoływana podczas usuwania
    private func confirmDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            taskToDelete = tasks[index]
            showConfirmationDialog = true
        }
    }
    
    // Funkcja usuwająca zadanie
    private func deleteTask() {
        if let taskToDelete = taskToDelete,
           let index = tasks.firstIndex(where: { $0.id == taskToDelete.id }) {
            tasks.remove(at: index)
            self.taskToDelete = nil
        }
    }
}

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    var onAdd: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Wprowadź tytuł zadania", text: $title)
            }
            .navigationTitle("Dodaj Zadanie")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Anuluj") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Dodaj") {
                        if !title.isEmpty {
                            onAdd(title)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    ContentView()
}
