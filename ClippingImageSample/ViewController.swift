//
//  ViewController.swift
//  ClippingImageSample
//
//  Created by Daichi Hayashi on 2021/08/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()
    }

    // MARK: - private function

    private func setupImageView() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(addSelectionFrame(_:)))

        imageView.addGestureRecognizer(tapGesture)
    }

    @objc private func addSelectionFrame(_ sender: UITapGestureRecognizer) {

        let tappedPoint = sender.location(in: view)
        let selectionFrame = generateAndShowSelectionFrame(to: tappedPoint)
    }

    private func generateAndShowSelectionFrame(to location: CGPoint) -> SelectionFrameView {

        let frameView = SelectionFrameView(frame: CGRect(origin: location, size: .zero))

        view.addSubview(frameView)

        return frameView
    }

    /// contentMode を設定すると UIImageView とその UIImage の size が異なるので
    /// UIImageView の frame から UIImage の frame に変換するメソッド
    /// ただしサンプルアプリなので contentMode = .scaleAspectFill 限定
    private func convertImageOrigin(from frame: CGRect, of imageView: UIImageView) -> CGRect? {

        guard let image = imageView.image else { return nil }

        let imageViewAspectRatio = imageView.frame.width / imageView.frame.height
        let imageAspectRatio = image.size.width / image.size.width

        let scaleX = image.size.width / imageView.frame.size.width
        let scaleY = image.size.height / imageView.frame.size.height

        if imageView.contentMode == .scaleAspectFill {

            let scale = min(scaleX, scaleY)

            if imageViewAspectRatio < imageAspectRatio {
                // この場合、 imageView に対して image が横に長く、左右がクロップされている

                // 表示部分の image 幅
                let insideImageWidth = image.size.width * imageViewAspectRatio / imageAspectRatio
                // クロップされている片方の幅
                let leftCloppedImageWidth = (image.size.width - insideImageWidth) / 2

                let transform = CGAffineTransform(scaleX: scale, y: scale)
                transform.translatedBy(x: leftCloppedImageWidth, y: 0)

                return frame.applying(transform)

            } else {
                // この場合、 imageView に対して image が縦に長く、上下がクロップされている

                // 表示部分の image 高さ
                let insideImageHeight = image.size.height * imageAspectRatio / imageViewAspectRatio
                // クロップされている片方の高さ
                let topCloppedImageHeight = (image.size.height - insideImageHeight) / 2

                let transform = CGAffineTransform(scaleX: scale, y: scale)
                transform.translatedBy(x: 0, y: topCloppedImageHeight)

                return frame.applying(transform)
            }
        }

        // 今は scaleAspectFill しか考えず、それ以外は nil を返す
        return nil
    }
}

