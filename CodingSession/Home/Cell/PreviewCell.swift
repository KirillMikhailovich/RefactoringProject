//
//  PreviewCell.swift
//  CodingSession
//
//  Created by Kiryl Mikhailovich on 3.12.23.
//

import UIKit

final class PreviewCell: UICollectionViewCell {

    private struct Constants {
        static let titleOffset: CGFloat = 8.0
    }

    private var thumbImageView: UIImageView!
    private var durationLabel: UILabel!

    var image: UIImage? {
        didSet {
            thumbImageView.image = image
        }
    }

    var title: String? {
        didSet {
            durationLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
    }

    private func style() {
        styleThumbImage()
        styleDurationTitle()
    }

    private func styleThumbImage() {
        thumbImageView = UIImageView(frame: .zero)
        contentView.addSubview(thumbImageView)

        thumbImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
    }

    private func styleDurationTitle() {
        durationLabel = UILabel(frame: .zero)
        contentView.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(Constants.titleOffset)
            make.bottom.equalTo(-Constants.titleOffset)
        }
    }

}
