//
//  global.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/20/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import Foundation
import MapKit

class Main {
    var everyCrumb: Array<Crumb>
    
    init () {
        self.everyCrumb = []
    }
    
    func addCrumb(crumb: Crumb) {
        self.everyCrumb.append(crumb)
        print(everyCrumb)
    }
    
    func returnCrumb() -> Array<Crumb>{
        return self.everyCrumb

    }

}