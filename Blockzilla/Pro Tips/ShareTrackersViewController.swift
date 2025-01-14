/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import SnapKit

class ShareTrackersViewController: UIViewController {

    private let trackerTitle: String
    private let shareTap: (UIButton) -> Void
    init(trackerTitle: String, shareTap: @escaping (UIButton) -> Void) {
        self.trackerTitle = trackerTitle
        self.shareTap = shareTap
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var trackerStatsLabel: UILabel = {
        let trackerStatsLabel = UILabel()
        trackerStatsLabel.font = .footnote14Light
        trackerStatsLabel.textColor = .secondaryText
        trackerStatsLabel.numberOfLines = 2
        trackerStatsLabel.setContentHuggingPriority(.required, for: .horizontal)
        trackerStatsLabel.setContentCompressionResistancePriority(.trackerStatsLabelContentCompressionPriority, for: .horizontal)
        return trackerStatsLabel
    }()

    private lazy var shieldLogo: UIImageView = {
        let shieldLogo = UIImageView()
        shieldLogo.image = .trackingProtectionOn
        shieldLogo.tintColor = UIColor.white
        return shieldLogo
    }()

    private lazy var trackerStatsShareButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.secondaryText, for: .normal)
        button.titleLabel?.font = .footnote14Light
        button.titleLabel?.textAlignment = .center
        button.setTitle(UIConstants.strings.share, for: .normal)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        button.titleLabel?.numberOfLines = 0
        button.layer.borderColor = UIColor.secondaryText.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: CGFloat.trackerStatsShareButtonTopBottomPadding, left: CGFloat.trackerStatsShareButtonLeadingTrailingPadding, bottom: CGFloat.trackerStatsShareButtonTopBottomPadding, right: CGFloat.trackerStatsShareButtonLeadingTrailingPadding)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        return button
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shieldLogo, trackerStatsLabel, trackerStatsShareButton])
        stackView.spacing = .shareTrackerStackViewSpacing
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        trackerStatsLabel.text = trackerTitle
        shieldLogo.snp.makeConstraints {
            $0.size.equalTo(CGFloat.shieldLogoSize)
        }
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(CGFloat.shareTrackersLeadingTrailingOffset)
            $0.trailing.lessThanOrEqualToSuperview().offset(CGFloat.shareTrackersLeadingTrailingOffset)
        }
    }

    @objc private func shareTapped(sender: UIButton) {
        shareTap(sender)
    }
}

fileprivate extension CGFloat {
    static let shieldLogoSize: CGFloat = 20
    static let trackerStatsShareButtonTopBottomPadding: CGFloat = 10
    static let trackerStatsShareButtonLeadingTrailingPadding: CGFloat = 8
    static let shareTrackersLeadingTrailingOffset: CGFloat = 16
    static let shareTrackerStackViewSpacing: CGFloat = 16
}

fileprivate extension UILayoutPriority {
    static let trackerStatsLabelContentCompressionPriority = UILayoutPriority(999)
}
