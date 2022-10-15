//
//  ContentView.swift
//  Notification
//
//  Created by Shahnaz EK on 11/10/22.
//

import SwiftUI
import UserNotifications

// add the object of DateFile here
// in the notification change the content and title to the content and title from this app using the object of the DateFile created above
// use on appaear to send the badge if the app is in the foreground as the local notification doesn't come up when the app is in the foreground

struct ContentView: View {
    
    var body: some View {
        DatePickerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
