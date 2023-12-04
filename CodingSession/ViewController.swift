//
//  ViewController.swift
//  CodingSession
//
//  Created by Pavel Ilin on 01.11.2023.
//

import UIKit
import SnapKit
import Accelerate
import Photos

final class ViewController: UIViewController {

    private struct Constants {
        static let previewSize: CGSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        static let cellIdentifier = "SearchPreferencesCell"
    }

    private var collectionView: UICollectionView!

    var assets: [PHAsset] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assets = GalleryManager.loadVideos()
    }

    private func style() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset = .zero
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.minimumLineSpacing = 0
        collectionFlowLayout.itemSize = Constants.previewSize

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.dataSource = self
    }

}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)

        guard let cell = cell as? PreviewCell else { return UICollectionViewCell() }
        
        let asset = self.assets[indexPath.row]

        GalleryManager.loadPreview(asset: asset,
                                   targetSize: Constants.previewSize) { image in
            cell.image = image
        }

        cell.title = asset.duration.previewString

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }
}
