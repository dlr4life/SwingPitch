//
//  ViewController.swift
//  SwingPitch
//
//  Created by dlr4life on 2/13/19.
//  Copyright © 2019 dlr4life. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let terms = ["Release",
                 "Timing",
                 "Delivery",
                 "Spin Direction",
                 "Release Velocity",
                 "Spin Rate",
                 "Spin Direction",
                 "Time to Plate",
                 "Reach Back to Release Time",
                 "Extension",
                 "Impact Momentum",
                 "The Four-Seam Fastball",
                 "The Two-Seam Fastball",
                 "The Changeup",
                 "The Curveball",
                 "The Slider",
                 "The Forkball",
                 "The Knuckleball",
                 "The Split Finger",
                 "Max Acceleration",
                 "Power",
                 "Applied Power",
                 "Speed",
                 "Quickness",
                 "Control",
                 "Swing Path Measurements",
                 "Hip rotation",
                 "Attack angle",
                 "Max Hand Speed",
                 "Max Barrel Speed",
                 "Speed Efficiency",
                 "Trigger to Impact Time",
                 "Bat Vertical",
                 "Distance in the Zone",
                 "Hand Cast Distance",
                 "Approach Angle at Impact",
                 "Stance",
                 "Hip Placement",
                 "Movement",
                 "Pre-Swing",
                 "Grip",
                 "Stride",
                 "Run Drills"]
    
    let definitions = ["Release Definition",
                       "Timing Definition",
                       "Delivery Definition",
                       "Spin Direction Definition",
                       "Release Velocity Definition",
                       "Spin Rate Definition",
                       "Spin Direction Definition",
                       "Time to Plate Definition",
                       "Reach Back to Release Time Definition",
                       "Extension Definition",
                       "Impact Momentum Definition",
                       "The Four-Seam Fastball Definition",
                       "The Two-Seam Fastball Definition",
                       "The Changeup Definition",
                       "The Curveball Definition",
                       "The Slider Definition",
                       "The Forkball Definition",
                       "The Knuckleball Definition",
                       "The Split Finger Definition",
                       "Max Acceleration Definition",
                       "Power Definition",
                       "Applied Power Definition",
                       "Speed Definition",
                       "Quickness Definition",
                       "Control Definition",
                       "Swing Path Measurements Definition",
                       "Hip rotation Definition",
                       "Attack angle Definition",
                       "Max Hand Speed Definition",
                       "Max Barrel Speed Definition",
                       "Speed Efficiency Definition",
                       "Trigger to Impact Time Definition",
                       "Bat Vertical Definition",
                       "Distance in the Zone Definition",
                       "Hand Cast Distance Definition",
                       "Approach Angle at Impact Definition",
                       "Stance Definition",
                       "Hip Placement Definition",
                       "Movement Definition",
                       "Pre-Swing Definition",
                       "Grip Definition",
                       "Stride Definition",
                       "Run Drills Definition"]
    
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    var definitionsDict = [String: [String]]()
    var definitionsSectionTitles = [String]()
    
    var items = [AnyObject]()
    var filteredItems = [AnyObject]()
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        createAnimalDict()
        createDefinitionDict()
    }
    
    func animateTable() {
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Update the filtered array based on the search text.
        //        let searchResults = animals
        tableView.reloadData()
    }
    
    // MARK: - Helper Methods
    
    func createAnimalDict() {
        for term in terms {
            let firstLetterIndex = term.index(term.startIndex, offsetBy: 1)
            _ = String(term[..<firstLetterIndex])
            let key = String(term.first!)
            
            if var values = animalsDict[key] {
                values.append(term)
                animalsDict[key] = values
            } else {
                animalsDict[key] = [term]
            }
        }
        
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles.sort() { $0 < $1 }
    }
    
    func createDefinitionDict() {
        for definition in terms {
            let firstLetterIndex = definition.index(definition.startIndex, offsetBy: 1)
            _ = String(definition[..<firstLetterIndex])
            let key = String(definition.first!)
            
            if var values = definitionsDict[key] {
                values.append(definition)
                definitionsDict[key] = values
            } else {
                definitionsDict[key] = [definition]
            }
        }
        
        definitionsSectionTitles = [String](definitionsDict.keys)
        definitionsSectionTitles.sort() { $0 < $1 }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return animalSectionTitles.count
    }
    
    // Right Sidebar data source
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return animalIndexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        // MARK: - My Inplementation
        var tIndex = index
        var tTitle = title
        while animalSectionTitles.index(of: tTitle) == nil && tIndex != 0 {
            tIndex -= 1
            tTitle = animalIndexTitles[tIndex]
        }
        return animalSectionTitles.index(of: tTitle) ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor.lightGray
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
        headerView.textLabel?.textColor = UIColor.blue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = animalSectionTitles[section]
        let values = animalsDict[key]!
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let key = animalSectionTitles[indexPath.section]
        let animalValues = animalsDict[key]!
        let animal = animalValues[indexPath.row]
        cell.textLabel?.text = animal
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.black
        
        // Convert the animal name to lower case and then replace all occurences of a space with an underscore
        _ = animal.lowercased().replacingOccurrences(of: " ", with: "_")
        cell.imageView?.image = UIImage(named: "pitch1")
        cell.imageView?.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let key = animalSectionTitles[indexPath.section]
        let animalValues = animalsDict[key]!
        let animal = animalValues[indexPath.row]
        
        let ac = UIAlertController(title: "Define: \(animalValues[indexPath.row])", message: nil, preferredStyle: .actionSheet)
        let call = UIAlertAction(title: "Show Definition", style: .default) {
            (action: UIAlertAction) -> Void in
            let acHandler = UIAlertController(title: "\(animalValues[indexPath.row]) Definition:", message: "Should Match: \(self.definitions[Int()].description)", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            acHandler.addAction(okButton)
            self.present(acHandler, animated: false, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(call)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        print("You selected \(animalValues[indexPath.row])")
    }
}
