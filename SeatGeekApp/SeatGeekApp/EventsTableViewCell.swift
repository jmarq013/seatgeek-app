//
//  EventsTableViewCell.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 1/6/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with event: Event) {
        self.titleLabel.text = event.title
        self.locationLabel.text = "\(event.venue.city), \(event.venue.state)"
        self.dateTimeLabel.text = Event.formatDateFromUTC(with: event.dateTime, for: "date")
        self.timeLabel.text = Event.formatDateFromUTC(with: event.dateTime, for: "time")
        if Favorites.isFavorite(event.id) {
            favoriteButton.isHidden = false
        } else {
            favoriteButton.isHidden = true
        }
        
        EventService.fetchImage(from: event.performers[0].imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.eventImageView.image = image
                case .failure(let error):
                    self.eventImageView.image = UIImage(systemName: "photo.on.rectangle")
                }
            }
        }
    }
    
}
