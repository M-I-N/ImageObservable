//
//  UserViewModel.swift
//  ImageObservable
//
//  Created by Mufakkharul Islam Nayem on 11/28/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Combine
import UIKit

class UserViewModel: ObservableObject {
    @Published var image = UIImage()
}
