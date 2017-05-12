# coding: utf-8
class ExpenseScreen < UI::Screen
  include Hiccup

  def status_bar_style
    :hidden
  end

  def header
    [:view, { flex_direction: :row },
     [:button, { id: :hamburger,
                 class: :hamburger,
                 title: '0xf0c9'.hex.chr(Encoding::UTF_8),
                 width: 50, height: 50 }],
     [:label, { flex: 1, text: 'Budget Simple', font: font.merge({ size: 20 }), align_self: :center }],
     [:view, { width: 50 }]]
  end

  def expense_form
    [:view, { padding_left: 20, padding_right: 20 },
     [:input, { id: :amount, placeholder: 'Amount*', keyboard: :numbers_and_punctuation }],
     [:input, { id: :category, placeholder: 'Category' }],
     [:input, { id: :date, placeholder: 'Date', date_picker: true }],
     [:button, { id: :save_expense,
                 title: 'Save',
                 tap: :save_expense }]]
  end

  def markup
    [:view, { background_color: '212225', flex: 1 },
     header,
     expense_form]
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
      hamburger: { background_color: :clear, font: font_awesome },
      button: { color: :white,
                height: 40,
                background_color: '5a82a5',
                border_width: 1,
                border_color: '212225',
                font: font,
                margin: 2 } }
  end

  def font_awesome
    { name: 'FontAwesome', size: 18, extension: :ttf }
  end

  def font
    { name: 'Courier', size: 18 }
  end
end
