# This is a Rails app and we want to load all the files in the app 
# when running this code.  To do so, your current working directory
# should be the top-level directory (i.e. /workspace/your-app/) and then run:
# rails runner labs/3-associations.rb

# **************************
# DON'T CHANGE OR MOVE
Activity.destroy_all
# **************************

# Lab 3: Associations
# - We've added data into the contacts table.  Next, we'll add data
#   into the activities table.  Follow the steps below to insert
#   activity data in the database.  Afterwards, display a
#   single salesperson's activity data:

# 1. insert 3 rows in the activities table with relationships to
# a single salesperson and 2 different contacts

new_activity = Activity.new
new_activity["salesperson_id"] = Salesperson.find_by("first_name" => "Ben", "last_name" => "Block").id
new_activity["contact_id"] = Contact.find_by("first_name" => "Tim", "last_name" => "Cook").id
new_activity["note"] = "Called Tim Cook"
new_activity.save

new_activity = Activity.new
new_activity["salesperson_id"] = Salesperson.find_by("first_name" => "Ben", "last_name" => "Block").id
new_activity["contact_id"] = Contact.find_by("first_name" => "Tim", "last_name" => "Cook").id
new_activity["note"] = "Emailed Tim Cook"
new_activity.save

new_activity = Activity.new
new_activity["salesperson_id"] = Salesperson.find_by("first_name" => "Ben", "last_name" => "Block").id
new_activity["contact_id"] = Contact.find_by("first_name" => "Jeff", "last_name" => "Bezos").id
new_activity["note"] = "Partied with Jeff Bezos"
new_activity.save

# 2. Display all the activities between the salesperson used above
# and one of the contacts (sample output below):

# ---------------------------------
# Activities between Ben and Tim Cook:
# - quick checkin over facetime
# - met at Cupertino

salesperson = Salesperson.find_by("first_name" => "Ben", "last_name" => "Block")
salesperson_full_name = "#{salesperson["first_name"]} #{salesperson["last_name"]}"

contact = Contact.find_by("first_name" => "Tim", "last_name" => "Cook")
contact_full_name = "#{contact["first_name"]} #{contact["last_name"]}"

puts "---------------------------------"
puts "Activities between #{salesperson_full_name} and #{contact_full_name}:"

activities = Activity.where("salesperson_id" => salesperson["id"], "contact_id" => contact["id"])
for activity in activities
    puts "- #{activity["note"]}"
end

# CHALLENGE:
# 3. Similar to above, but display all of the activities for the salesperson
# across all contacts (sample output below):

# ---------------------------------
# Ben's Activities:
# Tim Cook - quick checkin over facetime
# Tim Cook - met at Cupertino
# Jeff Bezos - met at Blue Origin HQ

puts "---------------------------------"
puts "#{salesperson_full_name}'s Activities:"
activities = Activity.where("salesperson_id" => salesperson["id"])
for activity in activities
    contact = Contact.find(activity["contact_id"])
    contact_full_name = "#{contact["first_name"]} #{contact["last_name"]}"
    puts "#{contact_full_name} - #{activity["note"]}"
end

# 3a. Can you include the contact's company?

# ---------------------------------
# Ben's Activities:
# Tim Cook (Apple) - quick checkin over facetime
# Tim Cook (Apple) - met at Cupertino
# Jeff Bezos (Amazon) - met at Blue Origin HQ

puts "---------------------------------"
puts "#{salesperson_full_name}'s Activities:"
activities = Activity.where("salesperson_id" => salesperson["id"])
for activity in activities
    contact = Contact.find(activity["contact_id"])
    contact_full_name = "#{contact["first_name"]} #{contact["last_name"]}"
    company = Company.find(contact["company_id"])
    company_name = company["name"]
    puts "#{contact_full_name} (#{company_name}) - #{activity["note"]}"
end

# CHALLENGE:
# 4. How many activities does each salesperson have?

# ---------------------------------
# Ben Block: 3 activities
# Brian Eng: 0 activities

puts "---------------------------------"

salespeople = Salesperson.all
for salesperson in salespeople
    salesperson_full_name = "#{salesperson["first_name"]} #{salesperson["last_name"]}"
    activities = Activity.where("salesperson_id" => salesperson["id"])
    puts "#{salesperson_full_name}: #{activities.length} activities"
end
