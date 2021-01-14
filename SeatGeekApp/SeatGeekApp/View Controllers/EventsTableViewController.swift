//
//  EventsTableViewController.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 12/14/20.
//

import UIKit

class EventsTableViewController: UITableViewController, UISearchResultsUpdating {
    var searchController = UISearchController()
    var events = [Event]()
    lazy var filteredEvents: [Event] = self.events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130.0
        
        navigationItem.searchController = searchController
        searchController.searchBar.showsCancelButton = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        EventService.fetchEvents { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let eventService):
                    self.updateUI(with: eventService.events!)
                case .failure(let error):
                    print(result)
                    self.displayError(error, title: "Failed to Fetch Events")
                }
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func updateUI(with events: [Event]) {
        DispatchQueue.main.async {
            print(events)
            self.filteredEvents = events
            self.events = events
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, searchString.isEmpty == false {
            filteredEvents = events.filter({ (event) -> Bool in
                event.title.localizedCaseInsensitiveContains(searchString)
            })
        } else {
            filteredEvents = events
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventsTableViewCell
        let event = filteredEvents[indexPath.row]
        cell.update(with: event)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? EventsTableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let event = filteredEvents[indexPath.row]
            let eventDetailViewController = segue.destination as! EventDetailViewController
            eventDetailViewController.event = event
            eventDetailViewController.eventImage = cell.eventImageView.image
            eventDetailViewController.isFavorite = Favorites.isFavorite(event.id)
        }
    }

}
