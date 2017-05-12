class ExpenseScreen
  def current_date
    components =
      NSCalendar.currentCalendar.components(
        NSCalendarUnitDay |
        NSCalendarUnitMonth |
        NSCalendarUnitYear,
        fromDate: NSDate.date
      )
    day = components.day
    month = components.month
    year = components.year

    [year, month, day]
  end
end
