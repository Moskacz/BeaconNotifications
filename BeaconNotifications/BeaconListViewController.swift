//
//  BeaconListViewController.swift
//  BeaconNotifications
//
//  Created by Michal Moskala on 23.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import CoreData

class BeaconListViewController: UIViewController {

    var repository: BeaconRegionRepository?
    
    @IBOutlet private weak var tableView: UITableView?
    private let cellReuseId = "beaconCell"
    private var frc: NSFetchedResultsController<BeaconRegion>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFRC()
        setupTableView()
    }
    
    private func setupFRC() {
        frc = repository?.frc
        frc?.delegate = self
    }
    
    private func setupTableView() {
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let addBeaconVC = segue.destination as? AddBeaconRegionViewController, let repo = repository {
            addBeaconVC.viewModel = AddBeaconRegionViewModel(repository: repo)
        }
    }
}

extension BeaconListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)!
        let region = frc!.object(at: indexPath)
        cell.textLabel?.text = [region.beaconId, region.uuid?.uuidString].flatMap { $0 }.joined(separator: " ")
        let detailsTextComponents = [("major", region.majorValue), ("minor", region.minorValue)]
        cell.detailTextLabel?.text = detailsTextComponents
            .filter { $0.1 != 0 }
            .map { return "\($0.0): \($0.1)"}
            .joined(separator: ", ")
        return cell
    }
}

extension BeaconListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}

extension BeaconListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.reloadData()
    }
}
