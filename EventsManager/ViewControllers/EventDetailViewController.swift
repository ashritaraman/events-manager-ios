//
//  EventDetailViewController.swift
//  EventsManager
//
//  Created by Ethan Hu on 3/20/18.
//
//

import UIKit
import MapKit
import Kingfisher

class EventDetailViewController: UIViewController {
    
    //Constants
    let buttonHeight:CGFloat = 40
    let buttonImageViewOffSet = CGFloat(integerLiteral: 20)
    let standardEdgeSpacing = CGFloat(integerLiteral: 20)
    let imageViewHeight = CGFloat(integerLiteral: 200)
    let infoStackEdgeSpacing = CGFloat(integerLiteral: 40)
    let iconSideLength = CGFloat(integerLiteral: 20)
    let infoStackIconLabelSpacing = CGFloat(integerLiteral: 15)
    let avatarSpacing = CGFloat(integerLiteral: 5)
    let infoTableSpacing = CGFloat(integerLiteral: 5)
    let buttonDividerTopBottomSpacing = CGFloat(integerLiteral: 5)
    let eventDiscriptionFontSize = CGFloat(integerLiteral: 16)
    let mapViewHeight = CGFloat(integerLiteral: 140)
    let tagScrollViewHeight = CGFloat(integerLiteral: 50)
    let tagHorizontalSpacing = CGFloat(integerLiteral: 8)
    let tagLabelFontSize = CGFloat(integerLiteral: 22)
    
    
    //datasource
    var event:Event?
    
    //view elements
    var scrollView = UIScrollView()
    var contentView = UIView()
    var eventImage = UIImageView()
    var interestedButton = UIButton()
    var goingButton = UIButton()
    var eventDiscription = UILabel()
    var eventTime = UILabel()
    var eventParticipants = UILabel()
    var eventOrganizer = UILabel()
    var eventLocation = UILabel()
    var eventMapView = MKMapView()
    var tagScrollView = UIScrollView()
    var tagStack = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
    }
    
    /* Sets all the layout elements in the details view */
    func setLayouts(){
        navigationItem.title = event?.eventName ?? ""
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.white
        scrollView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view.frame.width)
        }
        
        //interested and going buttons
        let buttonStackBackground = UIView()
        buttonStackBackground.backgroundColor = UIColor.darkSkyBlue
        buttonStackBackground.layer.cornerRadius = buttonHeight / 2
        buttonStackBackground.translatesAutoresizingMaskIntoConstraints = false
        interestedButton.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(buttonHeight)
        }
        goingButton.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(buttonHeight)
        }
        let buttonStack = UIStackView(arrangedSubviews: [interestedButton, goingButton])
        buttonStack.alignment = .center
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        let buttonDivider = UIView()
        buttonDivider.backgroundColor = UIColor.white
        buttonStack.insertSubview(buttonDivider, at: 1)
        buttonDivider.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(1)
            make.top.equalTo(buttonStack).offset(buttonDividerTopBottomSpacing)
            make.bottom.equalTo(buttonStack).offset(-buttonDividerTopBottomSpacing)
            make.left.equalTo(interestedButton.snp.right).offset(-0.5)
        }
        buttonStack.insertSubview(buttonStackBackground, at: 0)
        buttonStackBackground.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(buttonStack)
        }
        
        //table of info
        let calendarIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSideLength, height: iconSideLength))
        calendarIcon.image = #imageLiteral(resourceName: "magnifyingGlass")
        let calendarStack = UIStackView(arrangedSubviews: [calendarIcon, eventTime])
        calendarStack.alignment = .center
        calendarStack.axis = .horizontal
        calendarStack.distribution = .fill
        calendarStack.spacing = infoStackIconLabelSpacing
        
        let participantIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSideLength, height: iconSideLength))
        participantIcon.image = #imageLiteral(resourceName: "magnifyingGlass")
        let participantImageAndStringStack = UIStackView(arrangedSubviews: [eventParticipants])
        var avatars:[UIImageView] = []
        for _ in event?.avatars ?? []{
            if avatars.count < 3 {  //support maximum 3 avatars, if more than 3, only add first three to the array
                avatars.append(UIImageView(frame:CGRect(x: 0, y: 0, width: iconSideLength, height: iconSideLength)))
            }
        }
        for index in 0..<avatars.count {
            avatars[index].snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(iconSideLength)
                make.height.equalTo(iconSideLength)
            }
            avatars[index].layer.cornerRadius = avatars[index].frame.height/2
            avatars[index].clipsToBounds = true
            avatars[index].kf.setImage(with: event?.avatars[index])
        }
        for index in (0...avatars.count - 1).reversed() {
            participantImageAndStringStack.insertArrangedSubview(avatars[index], at: 0)
        }
        participantImageAndStringStack.axis = .horizontal
        participantImageAndStringStack.distribution = .fill
        participantImageAndStringStack.alignment = .center
        participantImageAndStringStack.spacing = avatarSpacing
        let participantStack = UIStackView(arrangedSubviews: [participantIcon, participantImageAndStringStack])
        participantStack.alignment = .center
        participantStack.axis = .horizontal
        participantStack.distribution = .fill
        participantStack.spacing = infoStackIconLabelSpacing
        
        let organizerIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSideLength, height: iconSideLength))
        organizerIcon.image = #imageLiteral(resourceName: "magnifyingGlass")
        let organizerStack = UIStackView(arrangedSubviews: [organizerIcon, eventOrganizer])
        organizerStack.alignment = .center
        organizerStack.axis = .horizontal
        organizerStack.distribution = .fill
        organizerStack.spacing = infoStackIconLabelSpacing
        
        let organzationTapGesture = UITapGestureRecognizer(target: self, action: #selector(orgNamePressed(_:)))
        eventOrganizer.addGestureRecognizer(organzationTapGesture)
        eventOrganizer.isUserInteractionEnabled = true
        
        
        let locationIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSideLength, height: iconSideLength))
        locationIcon.image = #imageLiteral(resourceName: "magnifyingGlass")
        let locationStack = UIStackView(arrangedSubviews: [locationIcon, eventLocation])
        locationStack.alignment = .center
        locationStack.axis = .horizontal
        locationStack.distribution = .fill
        locationStack.spacing = infoStackIconLabelSpacing
        
        let infoTableStack = UIStackView(arrangedSubviews: [calendarStack, participantStack, organizerStack, locationStack])
        infoTableStack.alignment = .leading
        infoTableStack.axis = .vertical
        infoTableStack.distribution = .fill
        infoTableStack.spacing = infoTableSpacing
        
        
        
        
        //Add three dividers between the elements of infoTableStack
        for index in stride(from: 1, through: 5, by: 2){
            let divider = UIView()
            divider.backgroundColor = UIColor.lightGray
            infoTableStack.insertArrangedSubview(divider, at: index)
            divider.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(infoTableStack)
                make.right.equalTo(infoTableStack)
                make.height.equalTo(1)
            }
        }
        
        
        let tagLabel = UILabel()
        tagLabel.text = NSLocalizedString("tag-button", comment: "")
        tagLabel.font = UIFont.boldSystemFont(ofSize: tagLabelFontSize)
        tagStack.insertArrangedSubview(tagLabel, at: 0)
        tagStack.alignment = .center
        tagStack.axis = .horizontal
        tagStack.distribution = .fill
        tagStack.spacing = tagHorizontalSpacing
        tagScrollView.addSubview(tagStack)
        
        
        
        
        contentView.addSubview(eventImage)
        contentView.addSubview(buttonStack)
        contentView.addSubview(eventDiscription)
        contentView.addSubview(infoTableStack)
        contentView.addSubview(eventMapView)
        contentView.addSubview(tagScrollView)
        
        
        //Constraints for UI elements
        eventImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo(imageViewHeight)
        }
        
        buttonStack.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eventImage.snp.bottom).offset(-buttonImageViewOffSet)
            make.left.equalTo(contentView).offset(standardEdgeSpacing)
            make.right.equalTo(contentView).offset(-standardEdgeSpacing)
        }
        
        eventDiscription.numberOfLines = 0
        eventDiscription.textAlignment = .justified
        eventDiscription.font = UIFont.systemFont(ofSize: eventDiscriptionFontSize)
        eventDiscription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(buttonStack.snp.bottom).offset(standardEdgeSpacing)
            make.left.equalTo(contentView).offset(standardEdgeSpacing)
            make.right.equalTo(contentView).offset(-standardEdgeSpacing)
        }
        
        infoTableStack.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eventDiscription.snp.bottom).offset(standardEdgeSpacing)
            make.left.equalTo(contentView).offset(infoStackEdgeSpacing)
            make.right.equalTo(contentView).offset(-infoStackEdgeSpacing)
        }
        
        eventMapView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(infoTableStack.snp.bottom).offset(standardEdgeSpacing)
            make.left.equalTo(contentView).offset(standardEdgeSpacing)
            make.right.equalTo(contentView).offset(-standardEdgeSpacing)
            make.height.equalTo(mapViewHeight)
        }
        
        tagScrollView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(eventMapView.snp.bottom).offset(standardEdgeSpacing)
            make.left.equalTo(contentView).offset(standardEdgeSpacing)
            make.right.equalTo(contentView).offset(-standardEdgeSpacing)
            make.height.equalTo(tagScrollViewHeight)
            make.bottom.equalTo(contentView).offset(-standardEdgeSpacing)
        }
        
        tagStack.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(tagScrollView)
        }
        
        
}
    
    /* Allow client to configure the event detail page by passing in an event object */
    func configure(with event:Event){
        self.event = event
        
        eventImage.kf.setImage(with: event.eventImage)
        interestedButton.setTitle(NSLocalizedString("interested-button", comment: ""), for: .normal)
        goingButton.setTitle(NSLocalizedString("going-button", comment: ""), for: .normal)
        
        eventDiscription.text = event.eventDescription
        eventTime.text = "\(NSLocalizedString("from", comment: "")) \(DateFormatHelper.hourMinute(from: event.startTime)) \(NSLocalizedString("to", comment: "")) \(DateFormatHelper.hourMinute(from: event.endTime))"
        eventOrganizer.text = event.eventOrganizer
        eventLocation.text = event.eventLocation
        eventParticipants.text = event.eventParticipant
        
        for tag in event.eventTags {
            let tagButton = EventTagButton()
            tagButton.setTitle(tag, for: .normal)
            tagButton.addTarget(self, action: #selector(self.tagButtonPressed(_:)), for: .touchUpInside)
            tagStack.addArrangedSubview(tagButton)
        }
        
    }
    
    /**
     Handler for the pressing action of the organization name. Should segue to the correct organization page.
     - sender: the sender of the action
     */
    @objc func orgNamePressed(_ sender: UITapGestureRecognizer){
        let testOrg = Organization(id: 1, name: "Cornell DTI", description: "Cornell DTI is a project team that creates technology to address needs on Cornell's campus, and beyond. Our team consists of 50 product managers, designers and developers working on 6 projects ranging from a campus safety app to a course review website. Check out our projects to see what we're up to!", avatar: URL(string: "https://avatars3.githubusercontent.com/u/19356609?s=200&v=4")!, photoID: [], events: [], members: [], website: "cornelldit.org", email:"connect@cornelldti.org")
        let orgController = OrganizationViewController()
        orgController.configure(organization: testOrg)
        navigationController?.pushViewController(orgController, animated: true)
    }
    
    /*
     * Handler for the pressing action of tag buttons. Should segue to the correct tagview controller.
     * - sender: the sender of the action.
     */
    @objc func tagButtonPressed(_ sender: UIButton) {
        let tagViewController = TagViewController()
        if let tagButton = sender as? EventTagButton {
            let tag = tagButton.getTagName()
            if let rootViewEventsDiscoveryController = navigationController?.viewControllers.first as? EventsDiscoveryController {
                tagViewController.setup(with: rootViewEventsDiscoveryController.events, for: tag)
                navigationController?.pushViewController(tagViewController, animated: true)
            }
        }
    }

}
