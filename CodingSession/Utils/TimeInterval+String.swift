//
//  TimeInterval+String.swift
//  CodingSession
//
//  Created by Kiryl Mikhailovich on 3.12.23.
//

import Foundation

extension TimeInterval {

    var previewString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.unitsStyle = .positional
        return formatter.string(from: self)
    }

}
