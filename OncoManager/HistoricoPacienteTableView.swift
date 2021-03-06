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
    var editar = UIButton()
    
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
        
        
        editar.setTitle("Editar", forState: .Normal)
        editar.frame = CGRectMake(0,0,30,20)
        editar.setTitleColor(UIColor.greenOM(), forState: .Normal)
        editar.titleLabel?.font = UIFont(descriptor: editar.titleLabel!.font.fontDescriptor(), size: 15)
        
        status.translatesAutoresizingMaskIntoConstraints = false
        addSubview(status)
        editar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editar)
        
        setupLabel(title, title: "Título", font: 17)
        setupLabel(subtitle, title: "Subtítulo", font: 15)
        setupLabel(details, title: "Detalhes", font: 15)
        details.textColor = UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[v1(12)]-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : title, "v1": status]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-26-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : subtitle]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-26-[v0]-8-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : details, "v1" : editar]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[v0(12)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : status]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v0]-3-[v1]-3-[v2]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : title, "v1" : subtitle, "v2" : details]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : editar]))
        
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

    var parent:PacienteViewController?
    var indexDoDelete:Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        tableView.registerClass(HistoricoPacienteCell.self, forCellReuseIdentifier: "HistCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HistoricoPacienteTableView.actOnNotificationSuccessDeleteExame), name: "notificationSucessDeleteExame", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HistoricoPacienteTableView.actOnNotificationErrorDeleteExame), name: "notificationErrorDeleteExame", object: nil)

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
        print("Entrou no number of rows in section");
        print(examesDoPaciente.count)
        return examesDoPaciente.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("HistCell", forIndexPath: indexPath) as! HistoricoPacienteCell
        print(indexPath.row)
        print(examesDoPaciente.count)
        let stringFinal:String!
        if examesDoPaciente.count > indexPath.row
        {
        print(examesDoPaciente[indexPath.row].nome)
        cell.title.text = examesDoPaciente[indexPath.row].nome
        stringFinal = (examesDoPaciente[indexPath.row].dataRealizado).convertNsDateToString()
        cell.subtitle.text = stringFinal
        cell.details.text = examesDoPaciente[indexPath.row].local
        cell.editar.tag = indexPath.row
        cell.editar.addTarget(parent, action: #selector(parent!.goToEditEvent(_:)), forControlEvents: .TouchUpInside)
        
        cell.status.colorStatus = parent!.returnStatusColor(indexPath.row)
        }
        
         //Configure the cell...

        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            DaoCloudKit().deleteExame(examesDoPaciente[indexPath.row])
            indexDoDelete = indexPath.row
            }
    }
    
    func actOnNotificationSuccessDeleteExame()
    {
        examesDoPaciente.removeAtIndex(indexDoDelete)
        dispatch_async(dispatch_get_main_queue(),{
        self.tableView.reloadData()
        })
    }
    func actOnNotificationErrorDeleteExame()
    {
        let alert=UIAlertController(title:"Erro", message: "Erro ao deletar o exame", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue(),{
        self.presentViewController(alert,animated: true, completion: nil)
        })
    }
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

