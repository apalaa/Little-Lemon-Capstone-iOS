//
//  Menu.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI
import CoreData


struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            // Header
            HStack {
                Group {
                    Image(systemName: "leaf.fill")
                    Text("Little Lemon App")
                        .font(.title)
                }
                Image(systemName: "person.circle.fill")
            }
            
            
            Text("Chicago")
            Text("This is an application to order from the Little Lemon restaurant.")
            
            TextField("Search Menu", text: $searchText)
            
            FetchedObjects<Dish, List>(
                predicate: buildPredicate(searchText),
                sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text(dish.title ?? "Unknown Dish")
                            Text("$" + String(dish.price ?? "Unknown Price"))
                            Spacer()
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
                }
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
        
        PersistenceController.shared.clear()
        
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

func buildPredicate(_ searchText: String) -> NSPredicate {
    if searchText.isEmpty {
        return NSPredicate(value: true)
    } else {
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}


#Preview {
    Menu()
}
