//
//  Optionals+Extensions.swift
//  RingTestProject
//
//  Created by Yaroslav Nosik on 29.01.2020.
//  Copyright © 2020 Yaroslav Nosik. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var valueOrEmpty: String {
        return self ?? ""
    }

    var asInt: Int {
        guard let self = self,
            let intValue = Int(self) else { return 0 }

        return intValue
    }

    var asDouble: Double {
        guard let self = self,
            let intValue = Double(self) else { return 0.0 }

        return intValue
    }
}

extension Optional where Wrapped == Int {
    var valueOrEmpty: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var valueOrEmpty: Double {
        return self ?? 0.0
    }
}
