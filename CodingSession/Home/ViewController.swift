//
//  ViewController.swift
//  CodingSession
//
//  Created by Pavel Ilin on 01.11.2023.
//

import UIKit
import SnapKit
import Photos

import RxSwift
import RxCocoa
import RxDataSources

final class ViewController: UIViewController {

    typealias SectionModel = AnimatableSectionModel<String, PHAsset>
    typealias PhotosDataSource = RxCollectionViewSectionedAnimatedDataSource<SectionModel>

    var viewModel: ViewModel?

    private struct Constants {
        static let previewSize: CGSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        static let cellIdentifier = "SearchPreferencesCell"
    }

    private var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()

    private lazy var dataSource: PhotosDataSource = {
        let dataSource = PhotosDataSource(configureCell: { [weak self] _, collectionView, path, asset in
            guard let self = self, let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier,
                                     for: path) as? PreviewCell else { return UICollectionViewCell() }

            GalleryManager.loadPreview(asset: asset,
                                       targetSize: Constants.previewSize) { image in
                cell.image = image
            }

            cell.title = asset.duration.previewString

            return cell
        })

        dataSource.decideViewTransition = { _, _, _ in .animated }

        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.input.updateVideos.accept(())
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
    }

    private func bind() {
        viewModel?.output.videos
            .filter({ !$0.isEmpty })
            .map { assets in [AnimatableSectionModel(model: "", items: assets)] }
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
