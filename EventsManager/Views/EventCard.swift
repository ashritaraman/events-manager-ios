//
//  EventCard.swift
//  EventsManager
//
//  Created by Ethan Hu on 4/23/18.
//
//

import UIKit
import SnapKit

//The view class for the event card in details page.
class EventCard: UIView {

    var event: Event?

    //View Elements
    let eventPicture = UIImageView()
    let monthLabel = UILabel()
    let dayLabel = UILabel()
    let startLabel = UILabel()
    let startContentLabel = UILabel()
    let goingLabel = UILabel()
    let goingContentLabel = UILabel()
    let eventNameLabel = UILabel()
    let locationLabel = UILabel()

    //Constants
    let cardWidth: CGFloat = 300
    let cardHeight: CGFloat = 300
    let eventPicHeight: CGFloat = 140
    let eventInfoHeaderFontSize: CGFloat = 16
    let eventInfoContentFontSize: CGFloat = 18
    let eventTitleFontSize: CGFloat = 18
    let eventLocationFontSize: CGFloat = 16
    let eventInfoStackInnerSpacing: CGFloat = 5
    let bottomStackInnerSpacing: CGFloat = 30
    let topStackInnerSpacing: CGFloat = 5
    let infoStackInnerSpacing: CGFloat = 8
    let cardStackInnerSpacing: CGFloat = 15
    let topStackLeftRightSpacing: CGFloat = 20
    let shadowOpacity: Float = 0.3
    let shadowRadius: CGFloat = 3
    let shadowOffset = CGSize(width: 1, height: 1)
    let cardRadius: CGFloat = 20

    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }

    /**
     * Populate the event card with an event object
     * - event: The event object that this card should populate with
     */
    func configure(with event: Event) {
        goingLabel.text = NSLocalizedString("going", comment: "")
        startLabel.text = NSLocalizedString("starts", comment: "")
        self.event = event
        monthLabel.text = DateFormatHelper.month(from: event.startTime)
        dayLabel.text = DateFormatHelper.day(from: event.startTime)
        startContentLabel.text = DateFormatHelper.hourMinute(from: event.startTime)
        goingContentLabel.text = "\(event.eventParticipantCount)"
        locationLabel.text = event.eventLocation
        eventNameLabel.text = event.eventName
        eventPicture.kf.setImage(with: event.eventImage)
    }

    /*
     * View Element setup and positioning for this event card.
     */
    func layoutUI() {
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.cornerRadius = cardRadius

        self.snp.makeConstraints { make in
            make.width.equalTo(cardWidth)
            make.height.equalTo(cardHeight)
        }
        eventPicture.clipsToBounds = true
        eventPicture.layer.cornerRadius = cardRadius
        eventPicture.contentMode = .scaleAspectFill
        eventPicture.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        eventPicture.snp.makeConstraints { make in
            make.width.equalTo(cardWidth)
            make.height.equalTo(eventPicHeight)
        }

        let eventInfoHeaderLabels = [monthLabel, startLabel, goingLabel]
        eventInfoHeaderLabels.forEach { $0.font = UIFont(name: "Dosis-SemiBold", size: eventInfoHeaderFontSize) }
        let eventInfoContentLabels = [dayLabel, startContentLabel, goingContentLabel]
        eventInfoContentLabels.forEach { $0.font = UIFont(name: "Dosis-Book", size: eventInfoContentFontSize)}

        let dateStack = UIStackView(arrangedSubviews: [monthLabel, dayLabel])
        dateStack.distribution = .fill
        dateStack.alignment = .center
        dateStack.axis = .vertical
        dateStack.spacing = eventInfoStackInnerSpacing

        let startTimeStack = UIStackView(arrangedSubviews: [startLabel, startContentLabel])
        startTimeStack.distribution = .fill
        startTimeStack.alignment = .center
        startTimeStack.axis = .vertical
        startTimeStack.spacing = eventInfoStackInnerSpacing

        let goingStack = UIStackView(arrangedSubviews: [goingLabel, goingContentLabel])
        goingStack.distribution = .fill
        goingStack.alignment = .center
        goingStack.axis = .vertical
        goingStack.spacing = eventInfoStackInnerSpacing

        let bottomStack = UIStackView(arrangedSubviews: [dateStack, startTimeStack, goingStack])
        bottomStack.distribution = .fillEqually
        bottomStack.alignment = .center
        bottomStack.axis = .horizontal
        bottomStack.spacing = bottomStackInnerSpacing

        eventNameLabel.font = UIFont(name: "Dosis-SemiBold", size: eventTitleFontSize)
        eventNameLabel.numberOfLines = 2

        locationLabel.font = UIFont(name: "Dosis-Book", size: eventLocationFontSize)
        locationLabel.textColor = UIColor.gray

        let topStack = UIStackView(arrangedSubviews: [eventNameLabel, locationLabel])
        topStack.distribution = .fill
        topStack.axis = .vertical
        topStack.alignment = .center
        topStack.spacing = topStackInnerSpacing

        let eventInfoStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        eventInfoStack.distribution = .fill
        eventInfoStack.axis = .vertical
        eventInfoStack.alignment = .center
        eventInfoStack.spacing = eventInfoStackInnerSpacing

        let cardStack = UIStackView(arrangedSubviews: [eventPicture, eventInfoStack])
        cardStack.distribution = .fill
        cardStack.alignment = .center
        cardStack.axis = .vertical
        cardStack.spacing = cardStackInnerSpacing

        self.addSubview(cardStack)
        cardStack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        topStack.snp.makeConstraints { make in
            make.left.equalTo(self).offset(topStackLeftRightSpacing)
            make.right.equalTo(self).offset(-topStackLeftRightSpacing)
        }

    }
}
