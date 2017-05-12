class ExpenseScreen < UI::Screen
  include Hiccup

  def status_bar_style
    :hidden
  end

  def markup
    [:view, { background_color: '212225', flex: 1, padding: 20 },
     [:label, { text: 'Budget Simple', font: font.merge({ size: 20 }) }],
     [:input, { id: :amount, placeholder: 'Amount*', keyboard: :numbers_and_punctuation }],
     [:input, { id: :category, placeholder: 'Category' }],
     [:input, { id: :date, placeholder: 'Date', date_picker: true }],
     [:button, { id: :save_expense,
                 title: 'Save',
                 tap: :save_expense }]]
  end

  def save_expense *_
    flash 'Amount is required.' and return if text(:amount) == ''
    flash 'Category is required.' and return if text(:category) == ''
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
               background_color: :clear,
               color: 'bcc4ca',
               margin: 5,
               height: 32,
               padding: 20,
               font: font,
               input_offset: 10 },
      flash: { background_color: '363a44' },
      button: { color: :white,
                height: 40,
                background_color: '5a82a5',
                border_width: 1,
                border_color: '212225',
                font: font,
                margin: 2 } }
  end

  def font
    { name: 'Courier', size: 18 }
  end
end
