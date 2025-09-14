//
//  PhotoViewer.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import Kingfisher
import SwiftUI

struct PhotoViewer: UIViewRepresentable {
  let imageURL: URL
  
  func makeUIView(context: Context) -> PhotoViewerView {
    let view = PhotoViewerView(imageURL: imageURL)
    return view
  }
  
  func updateUIView(_ uiView: PhotoViewerView, context: Context) {}
}

final class PhotoViewerView: UIView {
  private let scrollView: UIScrollView = UIScrollView()
  private let imageView: UIImageView = UIImageView()
  
  required init(imageURL: URL) {
    super.init(frame: .zero)
    
    scrollView.delegate = self
    scrollView.maximumZoomScale = 3.0
    scrollView.minimumZoomScale = 1.0
    addSubview(scrollView)

    imageView.alpha = 0
    imageView.kf.setImage(with: imageURL) { [weak self] _ in
      self?.imageView.alpha = 1
    }
    imageView.contentMode = .scaleAspectFit
    scrollView.addSubview(imageView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    scrollView.frame = bounds
    imageView.frame = scrollView.frame
  }
}

extension PhotoViewerView: UIScrollViewDelegate {
  public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
