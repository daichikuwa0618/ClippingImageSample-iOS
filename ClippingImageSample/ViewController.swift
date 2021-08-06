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
}

