//
//  Menu.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI
import CoreData

enum MenuCategories: String, CaseIterable {
    case starters = "Starters"
    case mains = "Mains"
    case desserts = "Desserts"
    case drinks = "Drinks"
    
}

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    @State private var selectedCategory: MenuCategories? = nil
    
    var body: some View {
        VStack {
            
            // Header
            HeaderLittleLemon()
            
            VStack(spacing: 0) {
                HeroLittleLemon()
                HStack {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.white)
                    TextField("", text: $searchText, prompt: Text("Search menu").foregroundStyle(Color.gray))
                        .foregroundStyle(Color.white)
                }
                .padding()
            }
            .background(greenCustom)
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text("ORDER FOR DELIVERY!")
                        .bold()
                    Spacer()
                }
                HStack {
                    ForEach(MenuCategories.allCases, id: \.self) { category in
                        Button(action: {
                            if selectedCategory == category {
                                selectedCategory = nil
                            } else {
                                selectedCategory = category
                            }
                        }) {
                            Text("\(category.rawValue)")
                                .bold()
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? greenCustom : greyCustom)
                                .foregroundColor(selectedCategory == category ? .white : greenCustom)
                                .clipShape(Capsule())
                                .font(.system(size: 14))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            FetchedObjects<Dish, AnyView>(
                predicate: buildPredicate(searchText, selectedCategory?.rawValue),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                AnyView(
                    List(dishes) { dish in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(dish.title ?? "Unknown Dish")
                                    .font(.title3)
                                    .bold()
                                Text(dish.itemDescription ?? "Unknown Dish")
                                    .font(.caption)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                Text(dish.category ?? "Unknown Category")
                                Text("$\(dish.price ?? "Unknown Price")")
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 70, height: 70)
                        }
                    }
                    .listStyle(.plain)
                )
            }
            
        }
        .onAppear() {
            getMenuData(viewContext)
        }
    }
    

    
}

func getMenuData(_ viewContext: NSManagedObjectContext) -> Void {
    
    let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }
    
    let urlRequest = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        
        
        
        if let error = error {
            print("ERROR FETCHING DATA: \(error.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("NO DATA RECEIVED.")
            return
        }

        let decoder = JSONDecoder()
        let decodedData = try? decoder.decode(MenuList.self, from: data)
        
        guard let decodedData = decodedData else {
            print("Error decoding")
            return
        }
        
        PersistenceController.shared.clear()
        
        for menuItem in decodedData.menu {
            let dish = Dish(context: viewContext)
            dish.title = menuItem.title
            dish.itemDescription = menuItem.description
            dish.category = menuItem.category
            dish.image = menuItem.image
            dish.price = menuItem.price
            dish.id = Int64(menuItem.id)
        }
        
        try? viewContext.save()

    }
    
    task.resume()
    
}

func buildSortDescriptors() -> [NSSortDescriptor] {
    
    return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCompare))]
    
}

func buildPredicate(_ searchText: String, _ category: String?) -> NSPredicate {
    
    var predicates: [NSPredicate] = []
    
    if let category = category {
        predicates.append(NSPredicate(format: "category contains [cd] %@", category))
    }
    
    if !searchText.isEmpty {
        predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
    }


    return predicates.isEmpty ? NSPredicate(value: true) : NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    
    
}

#Preview {
    Menu()
}
