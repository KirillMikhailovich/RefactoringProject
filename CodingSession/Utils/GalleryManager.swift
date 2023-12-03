//
//  GalleryManager.swift
//  CodingSession
//
//  Created by Kiryl Mikhailovich on 3.12.23.
//

import Photos
import UIKit

class GalleryManager {

    static func loadVideos() -> [PHAsset] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)

        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        var videoAssets: [PHAsset] = []

        fetchResult.enumerateObjects { (asset, _, _) in
            videoAssets.append(asset)
        }

        return videoAssets
    }

    static func loadPreview(asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()

        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat

        manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
            completion(image)
        }

    }

}

