//
//  TaskItem.swift
//  Todo App
//
//  Created by Yazid Al Ghazali on 26/11/20.
//

import SwiftUI

struct TaskItem: View {
    var task : Task
    var body: some View {
        VStack(alignment: .leading){
            Text(task.name!)
                .font(.headline)
                .bold()
            Spacer()
            Text(task.info!)
                .font(.subheadline)
        }
    }
}
