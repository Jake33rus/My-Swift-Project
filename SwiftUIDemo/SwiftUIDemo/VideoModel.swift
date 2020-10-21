//
//  VideoModel.swift
//  SwiftUIDemo
//
//  Created by Евгений Уланов on 19.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Combine

final class VideoModel: ObservableObject{
   @Published var title: String = "Apples"
   @Published var desctiption: String = "Eating big apples"
}
