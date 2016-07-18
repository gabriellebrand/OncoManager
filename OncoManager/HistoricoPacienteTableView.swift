//
//  HistoricoPacienteTableView.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/14/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit


class HistoricoPacienteCell: UITableViewCell {
    
    var title = UILabel()
    var subtitle = UILabel()
    var details = UILabel()
    var status: OMStatus!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViews(){
        let statusFrame = CGRectMake(0, 0, 15, 15)
        status = OMStatus(frame: statusFrame)
        status.backgroundColor = UIColor.clearColor()
        
        status.translatesAutoresizingMaskIntoConstraints = false
        addSubview(status)
//
//        subtitle.text = "subtitle"
//        subtitle.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(subtitle)
        
        setupLabel(title, title: "Título", font: 17)
        setupLabel(subtitle, title: "Subtítulo", font: 15)
        setupLabel(details, title: "Detalhes", font: 15)
        details.textColor = UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[v1(12)]-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : title, "v1": status]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-26-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : subtitle]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-26-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : details]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[v0(12)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : status]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v0]-3-[v1]-3-[v2]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : title, "v1" : subtitle, "v2" : details]))
        
    }
    
    func setupLabel(label: UILabel, title: String, font: CGFloat){
        label.text = title
        label.font = label.font.fontWithSize(font)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        addSubview(label)
    }

}


class HistoricoPacienteTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(HistoricoPacienteCell.self, forCellReuseIdentifier: "HistCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("HistCell", forIndexPath: indexPath) as! HistoricoPacienteCell
        print(indexPath.row)
        print(examesDoPaciente.count)
        if examesDoPaciente.count > indexPath.row
        {
        cell.title.text = examesDoPaciente[indexPath.row].nome
        cell.subtitle.text = String(examesDoPaciente[indexPath.row].dataRealizado)
        cell.details.text = examesDoPaciente[indexPath.row].local
        }
        
         //Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
