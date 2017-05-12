class ExpenseScreen
  def current_date
    calendar = Java::Util::Calendar.getInstance
    year = calendar.get(Java::Util::Calendar::YEAR)
    month = calendar.get(Java::Util::Calendar::MONTH)
    day = calendar.get(Java::Util::Calendar::DAY_OF_MONTH)

    [year, month, day]
  end
end
