//
//  DatePicker.swift
//  Notification
//
//  Created by Shahnaz EK on 11/10/22.
//

import SwiftUI
import UserNotifications

// The value of the date is stored in selectedDate.
// create a textfield for title and pass the value of title and selectedDate to class CoreDataViewModel's add function with parameteres text and reminder String

struct DatePickerView: View {
    
    //instances of the classes created
    @StateObject var vm = CoreDataViewModel()
    
    @State var titleName : String = ""
    @State var reminderSet : String = ""
    @State var selectedDate : Date = Date()
    
    let notify = NotificationHandler()
       
    var dateFormatter : DateFormatter
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
               Text("Reminders")
                
                DatePicker("Select a Date", selection: $selectedDate, in: Date.now...)
                    .accentColor(Color.red)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(width: 320, height: 330)
                
                
                TextField("Enter a title here", text: $titleName)
                    .padding(.leading)
                    .frame(height: 40)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                

                Button {
                    guard !titleName.isEmpty else {return}
                    reminderSet = dateFormatter.string(from: selectedDate)
                    vm.addReminders(text: titleName, reminderText: reminderSet, reminderUUID: notify.uuidDelete)
                    vm.fetchReminders()
                    notify.askPermission()
                    
                    
                    notify.sendNotification(
                        date: selectedDate,
                        type: "date",
                        title: titleName, // this part not appearing in the notification received with the titlename, appears with a "string"
                        body: "Time for AppName") // this part is appearing im the notification
                    
                    titleName = ""


                } label: {
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                
                List{

                    if !vm.savedEntities.isEmpty{

                        Text("Reminders:")
                            .font(.title.bold())

                        ForEach(vm.savedEntities) { entity in
                            VStack(alignment: .leading){
                                    Text(entity.title ?? "No Title")
                                    Text(entity.dateandtime ?? "No Date Selected")
                                
                            }
                        }.onDelete(
                            perform: vm.deleteReminder
                        // this is where you call the func to delete notification
                        )
                            
                    }

                }
                .listStyle(PlainListStyle())

            }
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
