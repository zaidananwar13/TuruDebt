//
//  TransactionView.swift
//  uTang
//
//  Created by Fuad Fadlila Surenggana on 08/04/23.
//

import SwiftUI

struct TransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var person: Person
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
//        animation: .default)
//    private var transactions: FetchedResults<Transaction>

    @State private var transactionNote: String = ""
    
    

    @State var showingAddview: Bool = false

    var body: some View {
        
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("\(person.name!)").font(.title2) + Text("'s transaction history").foregroundColor(.red)
                    Text("Rp. \(Int(totalDebt())) ,-")
                        .foregroundColor(totalDebt() < 0 ? Color.red : Color.black)
                }.padding(.horizontal)
                List {
                    ForEach(person.transactionsArray) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.unwrappedNote)
                                Text("\(transaction.unwrappedDate.formatted(.dateTime.day().month().year()))")
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                            Spacer()
                            Text("\(Int(transaction.unwrappedNominal))")
                                .foregroundColor(transaction.unwrappedNominal < 0 ? Color.red : Color.black)
                        }
                        
                    }
                    .onDelete(perform: deleteTransaction)
                }
                Spacer()
            }
            

            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddview.toggle()
                    } label: {
                        Label("add food", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddview) {
                AddTransactionView(person: person)
            }
        
    }

    func totalDebt() -> Double {
        var debt: Double = 0
        for item in person.transactionsArray {
            debt += item.unwrappedNominal
        }
        return debt
    }

    func deleteTransaction(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let transaction = person.transactionsArray[index]
                viewContext.delete(transaction)
                PersistenceController.shared.saveContext()
            }
        }
    }

}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newPerson = Person(context: viewContext)
        newPerson.name = "Fuad"

        let trans1 = Transaction(context: viewContext)

        trans1.note = "Jobz"

        let trans2 = Transaction(context: viewContext)

        trans2.note = "Woz"

        newPerson.addToTransactions(trans2)
        newPerson.addToTransactions(trans1)

        return TransactionView(person: newPerson)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
