//
//  functions2.swift
//  klisfer
//
//  Created by aayush chaubey on 24/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import Foundation


class objects1 {
    
    // These are the properties you can store in your singleton
    var stylistData1: [stylist] = []
    var servicessMen1: [services_common] = []
    var servicessWomen1: [services_common] = []
    var servicessChildren1: [services_common] = []
    
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: objects {
        struct Static {
            static let instance = objects()
        }
        return Static.instance
    }
}
