class ExpenseScreen < UI::Screen
  include Hiccup

  def on_load
    $self = self
    render markup, css
    ViewState.current_screen = self
    view.update_layout
  end

  def move_view
    views[:root][:view].proxy.frame = CGRectMake(0, -300, 100, 100)
  end

  def markup
    [:view, { background_color: '212225', flex: 1, padding: 40 },
     [:label, { text: 'Budget Simple' }],
     [:input, { id: :amount, placeholder: 'Amount', keyboard: :numbers_and_punctuation }],
     [:input, { id: :category, placeholder: 'Category' }],
     [:input, { id: :date,
                placeholder: 'Date',
                date_picker: true,
                on_change: :format_date_input,
                text: format_date(*current_date) }],
     [:button, { id: :save_expense,
                 title: 'Save',
                 tap: :save_expense }]
     ]
  end

  def current_date
    if ViewState.android?
      calendar = Java::Util::Calendar.getInstance
      year = calendar.get(Java::Util::Calendar::YEAR)
      month = calendar.get(Java::Util::Calendar::MONTH)
      day = calendar.get(Java::Util::Calendar::DAY_OF_MONTH)
    else
      components = NSCalendar.currentCalendar.components(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear, fromDate: NSDate.date)
      day = components.day
      month = components.month
      year = components.year
    end

    [year, month, day]
  end

  def format_date year, month, day
    "#{month}/#{day}/#{year}"
  end

  def format_date_input sender, *args
    sender.text = format_date(*args)
  end

  def save_expense sender, attributes
    if views[:amount][:view].text == ''
      flash 'Amount is required.'
    end
  end

  def css
    { label: { text_alignment: :center,
               margin: 10,
               color: 'bcc4ca',
               font: font },
      link: { border_width: 0,
              color: :white,
              font: font.merge(size: 20) },
      input: { border_width: 1,
               border_color: '5f5f60',
               border_radius: 5,
               background_color: :clear,
               color: 'bcc4ca',
               margin: 5,
               height: 32,
               padding: 20,
               font: font,
               input_offset: 10 },
      button: { color: :white,
                height: 40,
                background_color: '5a82a5',
                border_radius: 8,
                border_width: 1,
                border_color: '212225',
                font: font,
                margin: 2 } }
  end

  def font
    { name: 'Existence-Light', size: 18, extension: :otf }
  end
end