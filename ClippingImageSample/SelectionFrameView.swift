//
//  SelectionFrameView.swift
//  ClippingImageSample
//
//  Created by Daichi Hayashi on 2021/08/06.
//

import UIKit

final class SelectionFrameView: UIView {

    private let width: CGFloat = 80
    private let height: CGFloat = 80

    override init(frame: CGRect) {
        // 与えられた frame の位置を中心座標として、自身の frame を決定する
        let selfOrigin = CGPoint(x: frame.origin.x - width / 2, y: frame.origin.y - height / 2)
        let selfSize = CGSize(width: width, height: height)
        let selfFrame = CGRect(origin: selfOrigin, size: selfSize)

        super.init(frame: selfFrame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private function

    func setup() {
        backgroundColor = UIColor.clear

        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 12
    }
}
