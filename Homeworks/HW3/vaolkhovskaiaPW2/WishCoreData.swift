//
//  WishCoreData.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 24.03.2025.
//

import UIKit
import CoreData

@objc(Wish)
public class Wish: NSManagedObject {
    @NSManaged public var text: String?
    @NSManaged public var createdAt: Date?
}
