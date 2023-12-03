//
//  PHAsset+IdentifiableType.swift
//  CodingSession
//
//  Created by Kiryl Mikhailovich on 3.12.23.
//

import Photos
import Differentiator

extension PHAsset: IdentifiableType {
    public var identity: String {
        self.localIdentifier
    }
}
