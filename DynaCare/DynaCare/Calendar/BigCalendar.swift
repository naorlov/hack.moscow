//
//  BigCalendar.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 28/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation

import UIKit
import TimelineTableViewCell
import Alamofire
import AlamofireObjectMapper

class TimelineTableViewController: UITableViewController {
    let MainURL = URL(string: "http://35.204.85.94:8888/user_events/day")!;

    // TimelinePoint, Timeline back color, title, description, lineInfo, thumbnail, illustration
    var data:[Int: [(TimelinePoint, UIColor, String, String, String?, String?, String?)]] =
        [0:[
        (TimelinePoint(), UIColor.black, "12:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Sun"),
        (TimelinePoint(), UIColor.black, "15:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Sun"),
        (TimelinePoint(), UIColor.clear, "19:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Moon")
        ], 1:[
            (TimelinePoint(), UIColor.lightGray, "12:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "30 mins", "Apple", "Sun"),
            (TimelinePoint(), UIColor.lightGray, "13:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "120 mins", "Apple", "Sun"),
            (TimelinePoint(), backColor: UIColor.clear, "20:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", nil, nil, "Moon")
        ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var calEvents: [CalendarEvent] = [];
        let userToken = UserDefaults.standard.object(forKey:"Token") as! String
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        
        
        
        let now = dateformatter.string(from: Date())
        let tomorrow = dateformatter.string(from: Date().tomorrow);
        var ar_counter = 0;
        typealias bigbig = (TimelinePoint, UIColor, String, String, String?, String?, String?);
        var interm: [bigbig] = [];
        var oterm: [bigbig] = [];
        var flag: Bool = false;
        for date in [now] {
            let parameters: Parameters = [
                "day": date,
                "token": userToken
            ];
            
            DispatchQueue.main.async {
            Alamofire
                .request(
                    self.MainURL,
                    parameters: parameters
                )
                .responseArray {
                    [unowned self] (response: DataResponse<[CalendarEvent]>) -> Void in
                    
                    let druggsArray = response.result.value;
                    var events: [bigbig] = [];
                    if let druggsArray = druggsArray {
                        calEvents = druggsArray;
                        for event in druggsArray {
                            flag = true;
                            let formatter = DateFormatter()
                            // initially set the format based on your datepicker date / server String
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let myDateString = formatter.string(from: event.eventDate ?? Date());
                            
                            var desc = (event.desc ?? "Today I have an appointment!") + "\n\n";
                            desc += event.analysis ?? "Doctor told me that I'm going to live!";
                            
                            let event: bigbig = (
                                TimelinePoint(),
                                UIColor.lightGray,
                                myDateString,
                                desc,
                                Array<String>(arrayLiteral: "37 min", "42 min", "106 min").randomElement(),
                                event.eventType,
                                .some("Sun")
                            )
                            print(events)
                            events.append(event)
                        }
                        if ar_counter == 0 {
                            print("This")
                            self.data = [0: events];
                            interm = events;
                            self.tableView.reloadData();
                        } else {
                            print("That")
                            oterm = events;
                            self.data = [1: events];
                            self.tableView.reloadData();
                        }
                        ar_counter += 1;
                    }
                    print("This is flag: \(flag)\n")
                }
            print("This is flag: \(flag)\n")
            }
        }
        print("This is flag: \(flag)\n")
        
        if flag == true {
            print("Even here?")
            self.data = [
                0: interm,
                1: oterm
            ]
            self.tableView.reloadData();
            print(data)
        }
        

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle:nil);
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sectionData = data[section] else {
            return 0
        }
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day " + String(describing: section + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        
        // Configure the cell...
        guard let sectionData = data[indexPath.section] else {
            return cell
        }
        
        let (timelinePoint, timelineBackColor, title, description, lineInfo, thumbnail, illustration) = sectionData[indexPath.row]
        var timelineFrontColor = UIColor.clear
        if (indexPath.row > 0) {
            timelineFrontColor = sectionData[indexPath.row - 1].1
        }
        cell.timelinePoint = timelinePoint
        cell.timeline.frontColor = timelineFrontColor
        cell.timeline.backColor = timelineBackColor
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        cell.lineInfoLabel.text = lineInfo
        if let thumbnail = thumbnail {
            cell.thumbnailImageView.image = UIImage(named: thumbnail)
        }
        else {
            cell.thumbnailImageView.image = nil
        }
        if let illustration = illustration {
            cell.illustrationImageView.image = UIImage(named: illustration)
        }
        else {
            cell.illustrationImageView.image = nil
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionData = data[indexPath.section] else {
            return
        }
        
        print(sectionData[indexPath.row])
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    func generateRandomDate(daysBack: Int) -> Date? {
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
    
}
