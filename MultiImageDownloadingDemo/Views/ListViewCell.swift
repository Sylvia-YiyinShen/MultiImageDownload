//
//  ListViewCell.swift
//  MultiImageDownloadingDemo
//
//  Created by Yiyin Shen on 29/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var downloadedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: ListCellViewModel) {
        labelView.text = viewModel.title
        ImageDownloader.sharedInstance.fetchImageFor(urlString: viewModel.imageUrl) { (image, error) in
            if let image = image {
                self.downloadedImageView.image = image
            } else {
                print("failed to download image \(viewModel.imageUrl)")
            }
        }
    }
}
