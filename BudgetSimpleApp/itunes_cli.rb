require 'fastlane'
require 'httparty'

Spaceship.login 'ar@amirrajan.net'

def options
  [:list_apps, :go_to_apps, :create_app]
end

def list_apps
  Spaceship.app.all.each do |a|
    puts "#{a.name}: #{a.bundle_id}"
  end
end

def go_to_apps
  puts 'opening https://developer.apple.com/account/ios/identifier/bundle/'
  system 'open https://developer.apple.com/account/ios/identifier/bundle/'
end

def gets
  STDIN.gets.chomp
end

class String
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.try(:size) || 0
    gsub(/^[ \t]{#{indent}}/, '')
  end
end

def create_app
  puts <<-INSTRUCTIONS.strip_heredoc
  I need the name of your app.
    - Using spaces is fine.
    - Make the app name memorable because this is what people will use to find your app in the App Store.
    - Here are examples of BAD app names:
      - `Threes!` Why? Because it has an exclamation point (punctuation). Apps that use punctuation are hard to find.
      - `T.L.D.R. Reddit` Why? Because it has periods (punctuation). Apps that use punctuation are hard to find.
      - `Heroes Fighting` Why? Heroes is a saturated app keyword (there are many others). It'll make your app incredibly difficult to find.

  INSTRUCTIONS

  print "Pressure's on, what will you name your app?: "

  app_name = gets
  puts 'I need an app website/company website to generate an app ID. Examples: amirrajan.net, rubymotion.com'
  website = gets
  recommended_app_id = website.split('.').reverse.join '.'
  recommended_app_id += '.' + app_name.downcase.delete(' ')
  puts 'Here is the App ID I would recommend.'
  puts recommended_app_id
  puts "You can change it if you'd like (or just press enter to go to the next step):"
  override_recommended_app_id = gets
  recommended_app_id = override_recommended_app_id unless override_recommended_app_id.length.zero?
  app_id = recommended_app_id
  puts "Alright, here is the app that I'll create for you: "
  puts '#{app_name}'
  puts '#{app_id}'
  puts "Looks good? Type 'y' or 'n'"
  answer = gets
  if answer.downcase == 'y'

  end
end

continue = true

while continue
  puts ''
  puts 'CLI options:'
  options.map { |o| puts "- #{o}" }
  puts ''

  print 'What would you like to do (choose from the list above): '

  input = gets

  continue = false and next if input == 'exit'

  puts 'Invalid option.' and next unless options.include? input.to_sym
  puts ''

  send(input.to_sym)
end

# # Create a new app
# app = Spaceship.app.create!(bundle_id: "com.scratchworkdevelopment.budgetSimple", name: "Budget Simple")

# # Use an existing certificate
# cert = Spaceship.certificate.production.all.first

# # Create a new provisioning profile
# profile = Spaceship.provisioning_profile.app_store.create!(bundle_id: app.bundle_id,
#                                                          certificate: cert)

# # Print the name and download the new profile
# puts "Created Profile " + profile.name
# profile.download
