//
//  ViewModel.swift
//  CodingSession
//
//  Created by Kiryl Mikhailovich on 3.12.23.
//

import RxSwift
import RxCocoa
import Photos

final class ViewModel {

    struct Input {
        let updateVideos = PublishRelay<Void>()
    }

    struct Output {
        let videos: Driver<[PHAsset]>
    }

    let input = Input()
    let output: Output

    private let videos = BehaviorRelay<[PHAsset]>(value: [])
    private let disposeBag: DisposeBag

    init() {
        output = Output(videos: videos.asDriver())
        disposeBag = DisposeBag()
        bind()
    }

    func bind() {
        input.updateVideos.map { _ in
            return GalleryManager.loadVideos()
        }
        .bind(to: videos)
        .disposed(by: disposeBag)
    }


}
