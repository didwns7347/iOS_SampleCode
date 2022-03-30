//
//  ViewController.swift
//  covid-19
//
//  Created by yangjs on 2022/03/17.
//

import UIKit
import Charts
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    //알라모파이어에 컴플리션 핸들러는 메인큐에서 동작하기 때문에 따로 매인큐에 넣고 동작시킬 필요 없음
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.fetchCovidOverView { [weak self] result in
            guard let self = self else { return }
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden=true
            self.labelStackView.isHidden=false
            self.pieChartView.isHidden=false
            switch result{
            case let .success(result):
                self.configureStackView(koreaCovidOverView: result.korea)
                let covidOverViewList = self.makeCovidOverviewList(cityCovidOverView: result)
                self.configureChatView(covidOverViewList: covidOverViewList)
            case let .failure(error):
                debugPrint("error \(error)")
            }
            
        }
    }
    func makeCovidOverviewList(
        cityCovidOverView: CityCovidOverView
    )->[CovidOverView]{
        return [
            cityCovidOverView.seoul,
            cityCovidOverView.gyeonggi,
            cityCovidOverView.incheon,
            cityCovidOverView.gangwon,
            cityCovidOverView.sejong,
            cityCovidOverView.chungbuk,
            cityCovidOverView.chungnam,
            cityCovidOverView.jeonnam,
            cityCovidOverView.jeonbuk,
            cityCovidOverView.busan,
            cityCovidOverView.daegu,
            cityCovidOverView.ulsan,
            cityCovidOverView.gyeongnam,
            cityCovidOverView.gyeongbuk,
            cityCovidOverView.jeju
        ].sorted(by: {self.removeFormatString(string: $0.totalCase) < self.removeFormatString(string: $1.totalCase)})
    }
    
    func configureChatView(covidOverViewList:[CovidOverView]){
        self.pieChartView.delegate = self
        let entries = covidOverViewList.compactMap { [weak self] overview-> PieChartDataEntry?  in
            guard let self = self else {return nil}
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
                        ChartColorTemplates.joyful() +
                        ChartColorTemplates.liberty() +
                        ChartColorTemplates.pastel() +
                        ChartColorTemplates.material()
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }
    func removeFormatString(string:String)->Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    func configureStackView(koreaCovidOverView: CovidOverView){
        self.totalCaseLabel.text = "\(koreaCovidOverView.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverView.newCase)명"
    }
    
    func fetchCovidOverView(completionHandler: @escaping(Result<CityCovidOverView, Error>) -> Void)
    {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = ["serviceKey":"Q7oaiCWmwtfjy41srTkhN56IzZ3cdMuev"]
        AF.request(url, method: .get, parameters: param).responseData { response in
            switch response.result{
            case let .success(data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverView.self, from: data)
                    completionHandler(.success(result))
                }catch{
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    
    
}

extension ViewController: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailViewController  = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailViewController") as? CovidDetailViewController else {return}
        guard let covidOverView = entry.data as? CovidOverView else {return}
        covidDetailViewController.covidOverView = covidOverView
        self.navigationController?.pushViewController(covidDetailViewController, animated:  true)
    }
}
