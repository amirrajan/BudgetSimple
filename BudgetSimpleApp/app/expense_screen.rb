# coding: utf-8
class ExpenseScreen < UI::Screen
  include Hiccup
  include Styles

  def status_bar_style
    :hidden
  end

  def header
    [:view, { flex_direction: :row },
     [:button, { class: :hamburger, tap: :show_menu }],
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

  def show_menu
    nav_pop
  end

  def save_expense
    flash 'Amount is required.' and return if text(:amount) == ''
    flash 'Category is required.' and return if text(:category) == ''
  end

  def font_awesome
    { name: 'FontAwesome', size: 18, extension: :ttf }
  end

  def font
    { name: 'Courier', size: 18 }
  end
end
