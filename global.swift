//
//  global.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/20/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import Foundation

class Main {
    var everyCrumb: Array<Crumb>
    
    init () {
        self.everyCrumb = []
    }
    
    func addCrumb(crumb: Crumb) {
        everyCrumb.append(crumb)
        print(crumb)
        print("===========")
    }

}