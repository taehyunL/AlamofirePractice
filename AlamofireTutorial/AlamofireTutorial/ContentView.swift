//
//  ContentView.swift
//  AlamofireTutorial
//
//  Created by 이태현 on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = userListViewModel()
    
    var body: some View {
        List(vm.userList, id: \.self) { user in
            Text("\(user.page)")
            Text("\(user.total)")
            Text("\(user.totalPages)")
            ForEach(user.data, id: \.self) { data in
                Text("\(data.id)")
                Text("\(data.email)")
                Text("\(data.firstName)")
                Text("\(data.lastName)")
                AsyncImage(url: URL(string: data.avatar)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            vm.getUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
