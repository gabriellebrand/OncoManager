//
//  EstatisticasViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit
import Charts

class EstatisticasViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var graphTitleLabel: UILabel!
    
    let listGraphcs:[String] = ["Paciente x Plano","Paciente x Cirurgia","Paciente x Exame", "Paciente x Médico", "Paciente x Hospital"]
    var i = 0
    var months: [String] = ["Janeiro", "Fevereiro", "Março", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
    let points: [[Double]] = [[20.0, 14.0, 16.0, 13.0, 12.0, 16.0, 14.0, 18.0, 12.0, 14.0, 15.0, 14.0], [3.0, 4.0, 6.0, 3.0, 2.0, 6.0, 4.0, 8.0, 2.0, 4.0, 5.0, 4.0], [10.0, 14.0, 6.0, 3.0, 2.0, 6.0, 4.0, 8.0, 2.0, 14.0, 15.0, 14.0], [3.0, 4.0, 6.0, 3.0, 12.0, 16.0, 14.0, 8.0, 2.0, 4.0, 5.0, 4.0], [10.0, 14.0, 16.0, 3.0, 2.0, 6.0, 4.0, 8.0, 12.0, 14.0, 5.0, 4.0]]

    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        setChart(months, values: points[0])
        graphTitleLabel.text = listGraphcs[0]
        
        // Descrição do gráfico que aparece no canto inferir direito da interface
        chartView.descriptionText = ""
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        chartView.data = chartData
        
        //Colocar cores nos gráficos: .liberty(), .joyful(), .pastel(), .coloful(), .vordiplom()
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.liberty()
        
        //Colocar as informações do eixo x na parte abaixo do gráfico
        chartView.xAxis.labelPosition = .Bottom
        
        //Colocar cor no plano de fundo do gráfico:
        //chartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //Colocar animação no gráfico.
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //Mais opções em - SÓ QUE ESSA TA DANDO PROBLEMA:http://www.appcoda.com/ios-charts-api-tutorial/
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInOutElastic)
        
        //Adicionar uma LINHA LIMITE no gráfico
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        chartView.rightAxis.addLimitLine(ll)
        
    }
    
    @IBAction func nextGraphFunction(sender: AnyObject) {
        
        if i < listGraphcs.count - 1{
            
            
            if i < listGraphcs.count - 1 && i >= 0 {
                i = i + 1
            }
            graphTitleLabel.text = listGraphcs[i]
            setChart(months, values: points[i])
        }

    }
    
    @IBAction func backGraphFunction(sender: AnyObject) {
        
        if i > 0 {
            
            i = i - 1
            graphTitleLabel.text = listGraphcs[i]
            setChart(months, values: points[i])
        }
    }
    
    func calculaTempoMedioDeTodosOsExames(listaDeExames: [String], listaDeTodosOsExames: [Exame] ) -> [Int] {
        var index = 0
        var totDias: Int!
        var contTempo:  [Int] = []
        var contVezes: [Int] = []
        var diffDateComponents: NSDateComponents!
        
        //Inicializa os vetores contadormédiodedias e qtddevezesdeummesmoexame
        for i in 0..<listaDeExames.count{
            
            contTempo.append(0)
            contVezes.append(0)
        }
        
        for exame in listaDeTodosOsExames {
            
            //indice do vetor acumulador
            index = listaDeExames.indexOf(exame.nome)!
            
            if exame.tipoProcedimento == "Exame" {
                
                diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Day], fromDate: exame.dataMarcado, toDate: exame.dataRealizado, options: NSCalendarOptions.init(rawValue: 0))
                
                totDias = diffDateComponents.day
                
                contTempo[index] = totDias + contTempo[index]
                contVezes[index] = contVezes[index] + 1
            }
            
        }
        
        for i in 1..<listaDeExames.count{
            if contVezes[i] == 0{
                contTempo[i] = 0
            }
            else{
                contTempo[i] = contTempo[i]/contVezes[i]
            }
        }
        
        return contTempo
    }

    
        
}
 
