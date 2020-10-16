//
//  CalendarDataVCViewController.swift
//  Checklists
//
//  Created by Евгений Уланов on 01.10.2020.
//

import UIKit
import JTAppleCalendar

class CalendarDataVCViewController: UIViewController {

    @IBOutlet weak var calendarCollectionView: JTACMonthView!{
        didSet{
            calendarCollectionView.layer.cornerRadius = 30
            calendarCollectionView.layer.borderWidth = 1
            calendarCollectionView.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    var startDate: Date = Date()
    var finishDate: Date = Date()
    
    let formatter = DateFormatter()
    let numberOfRows = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollectionView.calendarDataSource = self
        calendarCollectionView.calendarDelegate = self
        configureCalendarView()
    }
    
    func configureCalendarView(){
        calendarCollectionView.minimumLineSpacing = 0
        calendarCollectionView.minimumInteritemSpacing = 0
        calendarCollectionView.register(UINib(nibName: "MonthHeader", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MonthHeader")
        self.calendarCollectionView.scrollToDate(Date(), animateScroll: false)
        self.calendarCollectionView.selectDates([ Date() ])
    }
    
    func configureCell(cell: JTACDayCell?, cellState: CellState) {
        guard let currentCell = cell as? CalendarCell else {
            return
        }
        
        currentCell.dateLabel.text = ""
        currentCell.iconImage.image = "🙃".image(resize: 40)
        configureSelectedStateFor(cell: currentCell, cellState: cellState)
        configureTextColorFor(cell: currentCell, cellState: cellState)
        let cellHidden = cellState.dateBelongsTo != .thisMonth
        currentCell.isHidden = cellHidden
    
    }
    // Configure text colors
    func configureTextColorFor(cell: JTACDayCell?, cellState: CellState){
        
        guard let currentCell = cell as? CalendarCell else {
            return
        }
        if cellState.isSelected{
            currentCell.dateLabel.textColor = UIColor.black
        }else{
            if cellState.dateBelongsTo == .thisMonth && cellState.date > Date()  {
                currentCell.dateLabel.textColor = UIColor.black
            }else{
                currentCell.dateLabel.textColor = UIColor.gray
            }
        }
    }
    
    func configureSelectedStateFor(cell: JTACDayCell?, cellState: CellState){
        
        guard let currentCell = cell as? CalendarCell else {
            return
        }
        if cellState.isSelected{
            currentCell.iconImage.image = currentCell.iconImage.image?.grayscale
        }else{
            currentCell.iconImage.image = "🙂".image(resize: 40)
        }
    }
}


extension CalendarDataVCViewController: JTACMonthViewDelegate, JTACMonthViewDataSource{
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        configureCell(cell: cell, cellState: cellState)
        
    }
    
    func configureCalendar(_ calendarUI: JTACMonthView) -> ConfigurationParameters {
        formatter.dateFormat = "dd MM yy"
        formatter.timeZone = TimeZone(identifier: "Europe/Moscow")
        formatter.locale = Locale(identifier: "ru_RU")
        calendarUI.scrollingMode = .stopAtEachSection
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 90, to: startDate)!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                endDate: endDate,
                                numberOfRows: numberOfRows,
                                calendar: Calendar.current,
                                generateInDates: .forAllMonths,
                                generateOutDates: .tillEndOfRow,
                                firstDayOfWeek: .monday,
                                hasStrictBoundaries: true)
        return parameters
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        configureCell(cell: cell, cellState: cellState)
        return cell
        
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(cell: cell, cellState: cellState)
    }
    
    
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "MonthHeader", for: indexPath)
        let date = range.start
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        formatter.timeZone = TimeZone(identifier: "Europe/Moscow")
        formatter.locale = Locale(identifier: "ru_RU")
        (header as! MonthHeader).monthName.text = formatter.string(from: date).capitalized
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 80)
    }
}
