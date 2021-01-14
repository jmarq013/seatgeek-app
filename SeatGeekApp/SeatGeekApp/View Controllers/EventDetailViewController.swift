//
//  EventDetailViewController.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 1/5/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    var event: Event?
    var isFavorite = false
    var eventImage: UIImage?
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var cityStateLabel: UILabel!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            updateUI(event)
        }
    }
    
    fileprivate func updateUI(_ event: Event) {
        dateTimeLabel.text = Event.formatDateFromUTC(with: event.dateTime, for: "default")
        cityStateLabel.text = "\(event.venue.city), \(event.venue.state)"
        eventImageView.image = eventImage
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.textAlignment = .center
        titleLabel.text = event.title
        navigationItem.titleView = titleLabel
        favoriteButton.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }

    @IBAction func setFavoriteEvent(_ sender: UIBarButtonItem) {
        if isFavorite {
            isFavorite = false
            favoriteButton.image = UIImage(systemName: "heart")
            Favorites.removeFromFavorties(event!.id)
        } else {
            isFavorite = true
            favoriteButton.image = UIImage(systemName: "heart.fill")
            Favorites.addToFavorites(event!.id)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
