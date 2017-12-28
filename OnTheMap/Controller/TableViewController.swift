//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if AppDelegate.shared.studentData == nil {
            requestData()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        requestData()
    }
    
    @IBAction func logOut(_ sender: Any) {
        logOutUdacity { data, response, error in
            performUIUpdatesOnMain {
                self.dismiss(animated: true, completion: nil)
                AppDelegate.shared.key = nil
                AppDelegate.shared.studentData = nil
            }
        }
    }
}

extension TableViewController {
    func requestData() {
        requestStudentData { data, response, error in
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let parseApiResponse: ParseApiResponse = try decoder.decode(ParseApiResponse.self, from: data!)
                performUIUpdatesOnMain {
                    AppDelegate.shared.studentData = parseApiResponse
                    self.tableView.reloadData()
                }
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.shared.studentData?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as! StudentCell
        guard let studentLocations = AppDelegate.shared.studentData?.results else {
            return cell
        }
        
        cell.nameLabel.text = "\(studentLocations[indexPath.row].firstName ?? "") \(studentLocations[indexPath.row].lastName ?? "")"
        cell.linkLabel.text = "\(studentLocations[indexPath.row].mediaURL ?? "")"
        return cell
    }
}
