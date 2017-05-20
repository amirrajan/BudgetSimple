require 'fastlane'
require 'httparty'
require_relative './amirs_brain/lib/app_store_search.rb'
require_relative './amirs_brain/lib/amirs_brain.rb'

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

def help_with_app_name
end

def help_with_certificates
  production = Spaceship.certificate.all.find_all { |c| c.is_a? Spaceship::Portal::Certificate::Production }.first

  development = Spaceship.certificate.all.find_all { |c| c.is_a? Spaceship::Portal::Certificate::Development }.first

  if production.nil? or development.nil?
    puts "You need to create a Production and Development certificate. This script doesn't support that stuff yet."
    system "open https://developer.apple.com/account/ios/certificate/"
    exit(0)
  end

  [development, production]
end

def create_app
  puts <<~INSTRUCTIONS
  I need the name of your app. Here are some tips:

  - Using spaces is fine.
  - Using a hypen after the main app name (eg: "Metal Gear - Tactical Espionage") is fine.
  - Make the app name memorable because this is what people will use to find your app in the App Store.
  - Here are examples of BAD app names:
    - "Threes!" Why? Because it has an exclamation point (punctuation) in the main app name. Apps that use punctuation are hard to find.
    - "T.L.D.R. Reddit" Why? Because it has periods (punctuation) in the main app name. Apps that use punctuation are hard to find.
    - "Heroes Fighting" Why? Heroes is a saturated app keyword (there are many others). It'll make your app incredibly difficult to find.

  INSTRUCTIONS

  continue = false
  while !continue
    print "Pressure's on, what will you name your app?: "
    app_name = gets
    puts "I'm going to show you what the search results for [#{app_name}] look like in the App Store (press enter to continue)."
    gets
    AmirsBrain.analyze(app_name)
    puts ""
    print 'Given the results above, do you want to change the name of your app? y/n: '
    continue = true if gets == 'n'
  end
  puts 'I need an app website/company website to generate an app ID. Examples: amirrajan.net, rubymotion.com'
  website = gets
  recommended_app_id = website.split('.').reverse.join '.'
  recommended_app_id += '.' + app_name.downcase.delete(' ')
  app_id = recommended_app_id
  puts "Alright, here is the app that I'll create for you: "
  puts app_name
  puts app_id
  puts 'Everything look good? y/n: '
  if gets == 'n'
    print 'What would you like the App ID to be? '
    app_id = gets
  end

  Spaceship.app.create!(bundle_id: app_id, name: app_name)

  puts "If all went well, [#{app_name}] has now been created. Select list_apps to continue."
end

continue = true

while continue
  puts ''
  puts 'Options:'
  puts ''
  options.map { |o| puts "- #{o}" }
  puts ''

  print 'What would you like to do (choose from the list above): '

  input = gets

  if input == 'exit'
    exit(0)
  end

  if options.include? input.to_sym
    system 'clear'
    send(input.to_sym)
  end
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
