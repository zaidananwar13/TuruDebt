//
//  ContentView.swift
//  uTang
//
//  Created by Fuad Fadlila Surenggana on 08/04/23.
//

import SwiftUI

struct MainViewEx: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var personName: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
    private var persons: FetchedResults<Person>
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Person Name", text: $personName)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addPerson) {
                        Label("", systemImage: "plus")
                    }
                }
                .padding()
                List {
                    ForEach(persons) { person in
                        NavigationLink(destination: TransactionView(person: person)) {
                            HStack {
                                Text(person.name ?? "")
                                Spacer()
                                Text("Rp. \(Int(totalDebt(transaction: person.transactionsArray))) ,-")
                                    .foregroundColor(totalDebt(transaction: person.transactionsArray) < 0 ? Color.red : Color.black)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deletePerson)
                }
            }
            .navigationTitle("Person")
        }
        
    }
    
    private func addPerson() {
        withAnimation {
            let newPerson = Person(context:viewContext)
            newPerson.id = UUID()
            newPerson.name = personName
            
            PersistenceController.shared.saveContext()
            
        }
    }
    
    func deletePerson(offsets: IndexSet) {
        withAnimation {
            offsets.map { persons[$0] }.forEach(viewContext.delete)
            
            PersistenceController.shared.saveContext()
        }
    }
    
    func totalDebt(transaction: [Transaction]) -> Double {
        var debt: Double = 0
        for item in transaction {
            debt += item.unwrappedNominal
        }
        return debt
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainViewEx()
    }
}
