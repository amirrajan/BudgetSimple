class ViewState
  class << self
    attr_accessor :currently_focused_control,
                  :current_screen,
                  :platform,
                  :device_screen_height
  end

  def self.ios?
    platform == :ios
  end

  def self.android?
    !ios?
  end

  def self.blur
    return unless currently_focused_control
    currently_focused_control.blur
    self.currently_focused_control = nil
  end
end
