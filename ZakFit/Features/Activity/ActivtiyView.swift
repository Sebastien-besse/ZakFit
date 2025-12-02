//
//  ActivtiyView.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI
import CardCarousel

struct ActivityView: View {
    @Bindable var vm: ActivityViewModel       // ← NOUVEAU
    @State private var selectedFilter: ActivityViewModel.ExerciseFilter = .all
    @Environment(\.dismiss) var dismiss
    var onCreated: ((ActivityDTO) -> Void)? = nil

    var filteredExercises: [ExerciseDTO] {
        switch selectedFilter {
        case .all:
            return vm.exercises
        case .musculation:
            return vm.exercises.filter { $0.type == "Musculation" }
        case .cardio:
            return vm.exercises.filter { $0.type == "Cardio" }
        case .bienEtre:
            return vm.exercises.filter { $0.type == "Bien-être" }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                headerExerciseFilter
                    .padding(.top, 12)

                if !filteredExercises.isEmpty {
                    Carousel(filteredExercises, id: \.id, isLooping: true) { ex in
                        VStack {
                            CardCarouselCell(
                                image: ex.name,
                                exercice: ex.name,
                                text: ex.type
                            )
                            .scaleEffect(vm.selectedExerciseID == ex.id ? 1.05 : 1.0)
                            .onTapGesture {
                                vm.selectedExerciseID = ex.id
                            }
                            .padding(.bottom, 30)
                        }
                    }
                    .frame(height: 340)
                } else {
                    Text("Aucun exercice dans cette catégorie")
                        .foregroundColor(.gray)
                        .padding()
                }

                Form {
                    Section("Durée") {
                        Stepper(value: $vm.duration, in: 1...300) {
                            Text("\(vm.duration) min")
                        }
                    }

                    Section("Date") {
                        DatePicker(
                            "Date de la séance",
                            selection: $vm.date,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }

                    Section("Calories (optionnel)") {
                        TextField("Calories", value: $vm.calories, format: .number)
                            .keyboardType(.numberPad)
                    }

                    if let error = vm.errorMessage {
                        Text(error).foregroundColor(.red)
                    }
                }

                Spacer()
            }
            .navigationTitle("Ajouter une activité")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Créer") {
                        Task {
                            if let activity = await vm.createActivity() {
                                onCreated?(activity)
                                dismiss()
                            }
                        }
                    }
                }
            }
            .task {
                await vm.fetchExercises()
            }
            .onChange(of: selectedFilter) { _ in
                vm.selectedExerciseID = filteredExercises.first?.id
            }
        }
    }

    var headerExerciseFilter: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(0.2))
            .overlay {
                HStack(spacing: 11) {
                    ForEach(ActivityViewModel.ExerciseFilter.allCases, id: \.self) { filter in
                        ButtonFilter(
                            name: filter.rawValue,
                            isFilter: selectedFilter == filter
                        ) {
                            selectedFilter = filter
                        }
                        if filter != ActivityViewModel.ExerciseFilter.allCases.last {
                            Divider()
                        }
                    }
                }
                .frame(width: 360, height: 36)
            }
            .frame(width: 378, height: 36)
    }
}





#Preview {
    @Previewable @State var mockVM = ActivityViewModel(token: "mock_token")
    let mockExercises: [ExerciseDTO] = [
        ExerciseDTO(id: UUID(), name: "Pump", type: "Musculation", defaultCaloriesPerMin: 6),
        ExerciseDTO(id: UUID(), name: "Course à pied", type: "Cardio", defaultCaloriesPerMin: 7),
        ExerciseDTO(id: UUID(), name: "Yoga", type: "Bien-être", defaultCaloriesPerMin: 4)
    ]
    
    mockVM.exercises = mockExercises
    mockVM.selectedExerciseID = mockExercises.first?.id
    mockVM.duration = 45
    mockVM.date = Date()
    mockVM.calories = nil
    
    return ActivityView(vm: mockVM)
}



