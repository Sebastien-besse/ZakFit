//
//  AddMealView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct AddMealView: View {
    let mealTypes = TypeMeal.allCases
    
    @State private var selected: TypeMeal = .breakfast
    @State var foodname: String
    @State var quantity: Int?
    
    // Pour stocker les quantités par aliment dans la liste horizontale
    @State private var quantities: [UUID: Int] = [:]
    
    // Tableau pour stocker les aliments ajoutés manuellement
    @State private var addedFoods: [AddedFood] = []
    
    struct AddedFood: Identifiable {
        let id = UUID()
        let name: String
        var quantity: Int
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                
                Text("NOUVEAU REPAS")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-2)
                    .foregroundStyle(.brownPrimary)
                    .frame(width: 300)
                    .padding(.top, 20)
                
                Image("NailDetailMeal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                
                // ——— Zone de sélection du type de repas
                HStack(alignment: .center, spacing: 20) {
                    VerticalCarousel(mealTypes) { type in
                        CardDetailMeal(text: type.rawValue, isKcal: false)
                            .onTapGesture { selected = type }
                    }
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.brownPrimary)
                        .frame(width: 4, height: 60)
                    
                    // Ajout d'aliment
                    VStack(alignment: .leading, spacing: 10) {
                        TextFieldFormCell(userData: $foodname, label: "Aliment", width: 130, height: 40)
                        
                        HStack(spacing: 10) {
                            TextFieldFormObjectifCellCentered(userData: Binding(
                                get: { quantity ?? 0 },
                                set: { quantity = $0 }
                            ), label: "g", width: 100, height: 40)
                            
                            Button {
                                guard !foodname.isEmpty, let q = quantity, q > 0 else { return }
                                addedFoods.append(AddedFood(name: foodname, quantity: q))
                                
                                foodname = ""
                                quantity = nil
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 18, weight: .black))
                                    .foregroundStyle(.brownPrimary)
                            }
                            .frame(width: 40, height: 40)
                            .background(Circle().fill(.pinkPrimary))
                        }
                    }
                }
                
                if !addedFoods.isEmpty{
                    // ——— Pastilles des aliments ajoutés
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(addedFoods) { food in
                                PelletFood(foodname: Binding(
                                    get: { food.name },
                                    set: { _ in }
                                )) {
                                    if let index = addedFoods.firstIndex(where: { $0.id == food.id }) {
                                        addedFoods.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                    
                    .padding(.horizontal, 20)
                }

                // ——— Protéines
                VStack(alignment: .leading) {
                    Text("Proteines")
                        .font(.custom("Futura Bold", size: 20))
                        .tracking(-1)
                        .foregroundStyle(.brownPrimary)
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(allFoods.filter { $0.type == .protein }) { food in
                                CardAddFood(
                                    image: food.image,
                                    foodname: food.name,
                                    quantiteNumber: Binding(
                                        get: { quantities[food.id] ?? 0 },
                                        set: { quantities[food.id] = $0 }
                                    )
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 220)
                }
                
                // ——— Glucides
                VStack(alignment: .leading) {
                    Text("Glucides")
                        .font(.custom("Futura Bold", size: 20))
                        .tracking(-1)
                        .foregroundStyle(.brownPrimary)
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(allFoods.filter { $0.type == .carb }) { food in
                                CardAddFood(
                                    image: food.image,
                                    foodname: food.name,
                                    quantiteNumber: Binding(
                                        get: { quantities[food.id] ?? 0 },
                                        set: { quantities[food.id] = $0 }
                                    )
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 220)
                }
                
                // ——— Bouton Ajouter le repas
                Button(role: .destructive) {
                    // Réinitialiser tous les champs
                    addedFoods.removeAll()
                    foodname = ""
                    quantity = nil
                    quantities.removeAll()
                    selected = .breakfast
                    print("Repas ajouté et réinitialisé")
                } label: {
                    Text("Ajouter")
                        .font(.custom("Futura Condensed ExtraBold", size: 22))
                        .foregroundColor(Color.background)
                        .padding()
                        .frame(width: 200)
                        .background(.brownPrimary)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                }
                .padding(.top, 50)
                
            }
            .padding(.bottom, 20)
        }
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    AddMealView(foodname: "", quantity: 0)
}
