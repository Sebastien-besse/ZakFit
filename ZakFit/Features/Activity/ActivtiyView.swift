//
//  ActivtiyView.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI
import CardCarousel

struct ActivityView: View {
    @Bindable var vm: ActivityViewModel
    @State private var selectedFilter: ActivityViewModel.ExerciseFilter = .musculation
    @Environment(\.dismiss) var dismiss
    var onCreated: ((ActivityDTO) -> Void)? = nil
    @State private var dateText: String = ""
  
    var filteredExercises: [ExerciseDTO] {
        switch selectedFilter {
        case .musculation: return vm.exercises.filter { $0.type == "Musculation" }
        case .cardio: return vm.exercises.filter { $0.type == "Cardio" }
        case .bienEtre: return vm.exercises.filter { $0.type == "Bien-être" }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("NOUVELLE SÉANCE")
                        .font(.custom("Futura Condensed ExtraBold", size: 40))
                        .tracking(-2)
                        .foregroundStyle(.brownPrimary)
                        .padding(.top, 20)
                    
                    // Filter
                    headerExerciseFilter
                    
                    // Date Input
                    VStack(alignment: .center, spacing: 4) {
                        Text("Date de la séance")
                            .font(.custom("Futura Bold", size: 20))
                            .foregroundStyle(.brownPrimary)
                        
                        TextField("JJ-MM-AAAA", text: $dateText)
                            .font(.custom("Futura Bold", size: 16))
                            .padding(8)
                            .foregroundStyle(.brownPrimary)
                            .background(Color.brownPrimary.opacity(0.1))
                            .cornerRadius(8)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                            .onChange(of: dateText) {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd-MM-yyyy"
                                if let d = formatter.date(from: dateText) {
                                    vm.date = d
                                }
                            }
                            .frame(width: 200)
                    }
                    .padding(.vertical)
                    
                    // Exercises Carousel
                    if !filteredExercises.isEmpty {
                        Carousel(filteredExercises, id: \.id, isLooping: true) { ex in
                            VStack {
                                CardCarouselCell(
                                    image: vm.imageForExercise(ex),
                                    exercice: ex.name,
                                    text: ex.motivationMessage
                                )
                                .scaleEffect(vm.selectedExerciseID == ex.id ? 1.05 : 1.0)
                                .onTapGesture { vm.selectedExerciseID = ex.id }
                            }
                        }
                        .frame(height: 340)
                        .padding(.vertical)
                    } else {
                        Text("Aucun exercice dans cette catégorie")
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    // Sliders
                    HStack(spacing: 16) {
                        // Duration / Dumbbell
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.brownPrimary)
                            .frame(width: 220, height: 160)
                            .overlay {
                                VStack(spacing: 12) {
                                    Text("Durée")
                                        .font(.custom("Futura Bold", size: 20))
                                        .foregroundStyle(Color.background)
                                    
                                    DumbbellMotivationView(
                                        sliderWidth: $vm.sliderWidth,
                                        lastDragValue: $vm.lastDragValue,
                                        sliderProgress: $vm.sliderProgress,
                                        maxWidth: vm.dumbbellMaxWidth
                                    )
                                    .frame(height: 60)
                                    
                                    Text("\(vm.duration) min")
                                        .font(.custom("Futura Bold", size: 12))
                                        .foregroundStyle(Color.background)
                                }
                                .padding(.horizontal)
                            }
                        
                        // Calories / Flame
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.brownPrimary)
                            .frame(width:130, height: 160)
                            .overlay {
                                VStack(spacing: 12) {
                                    Text("Brûlé")
                                        .font(.custom("Futura Bold", size: 20))
                                        .foregroundStyle(Color.background)
                                    
                                    FlameCaloriesCell(
                                        fillHeight: $vm.flameFillHeight,
                                        lastDragValue: $vm.flameLastDrag,
                                        progress: $vm.flameProgress,
                                        maxHeight: vm.flameMaxHeight
                                    )
                                    .frame(width: 100, height: 80)
                                    
                                    Text("\(vm.caloriesBurned) kcal")
                                        .font(.custom("Futura Bold", size: 12))
                                        .foregroundStyle(Color.background)
                                }
                                .padding(.horizontal)
                            }
                    }
                    .padding(.vertical)
                    
                    // Error message
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 20)
                    
                    // Create Button
                    Button(action: {
                        Task {
                            if let activity = await vm.createActivity() {
                                onCreated?(activity)
                                dismiss()
                            }
                        }
                    }) {
                        Text("Ajouter")
                            .font(.custom("Futura Bold", size: 20))
                            .foregroundStyle(Color.background)
                            .frame(width: 200)
                            .padding()
                            .background(Color.brownPrimary)
                            .cornerRadius(40)
                    }
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.background.edgesIgnoringSafeArea(.all))
            .scrollIndicators(.hidden)
            .task {
                if !vm.token.isEmpty {
                    await vm.fetchExercises()
                    vm.selectedExerciseID = filteredExercises.first?.id
                }
            }
            .onChange(of: selectedFilter) {
                vm.selectedExerciseID = filteredExercises.first?.id
            }
        }
    }
    
    // MARK: - Exercise Filter Header
    var headerExerciseFilter: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(Color.brownPrimary.opacity(0.5))
            .overlay {
                HStack(spacing: 11) {
                    ForEach(ActivityViewModel.ExerciseFilter.allCases, id: \.self) { filter in
                        ButtonFilter(
                            name: filter.rawValue,
                            isFilter: selectedFilter == filter
                        ) { selectedFilter = filter }
                        
                        if filter != ActivityViewModel.ExerciseFilter.allCases.last {
                            Divider()
                        }
                    }
                }
                .frame(width: 360, height: 36)
            }
            .frame(width: 350, height: 36)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var mockVM = ActivityViewModel(token: "mock_token")
    let mockExercises: [ExerciseDTO] = [
        ExerciseDTO(id: UUID(), name: "Pump", type: "Musculation", defaultCaloriesPerMin: 6,
                    motivationMessage: "Lève plus lourd que tes excuses"),
        ExerciseDTO(id: UUID(), name: "Haltéro", type: "Musculation", defaultCaloriesPerMin: 6,
                    motivationMessage: "Ta seule limite, c’est toi"),
        ExerciseDTO(id: UUID(), name: "Street Workout", type: "Musculation", defaultCaloriesPerMin: 6,
                    motivationMessage: "Ton objectif est tout pré"),
        ExerciseDTO(id: UUID(), name: "CrossFit", type: "Musculation", defaultCaloriesPerMin: 6,
                    motivationMessage: "Entraîne-toi !"),
        ExerciseDTO(id: UUID(), name: "Course à pied", type: "Cardio", defaultCaloriesPerMin: 7,
                    motivationMessage: "Cours pour être fier"),
        ExerciseDTO(id: UUID(), name: "Yoga", type: "Bien-être", defaultCaloriesPerMin: 4,
                    motivationMessage: "Respire. Recentre-toi. Progresse."),
    ]
    
    mockVM.exercises = mockExercises
    mockVM.selectedExerciseID = mockExercises.first?.id
    mockVM.duration = 0
    mockVM.date = Date()
    mockVM.calories = nil
    
    return ActivityView(vm: mockVM)
}


