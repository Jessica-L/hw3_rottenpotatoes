# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regexp = /#{e1}.*#{e2}/m #pg.236 in SAAS book
  page.body.should =~ regexp
  
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
    rating_list.split(%r{,\s*}).each do |rating| #ruby regex that removes , and whitespace chars => found this on ruby string doc page
    if uncheck.nil? #steps %Q found on pg.237 in SAAS book towards top
      steps %Q{
        When I check "ratings[#{rating}]"
      }
    else
      steps %Q{
        When I uncheck "ratings[#{rating}]"
      }
    end
  end
end

Then /I should see all of the movies/ do
  rows = page.all('table#movies tbody tr').size #tr is a tag for a row within the tbody in the table #movies
  rows.should == Movie.all.size
end

Then /I should see none of the movies/ do
  rows = page.all('table#movies tbody tr').size
  rows.should == 0
end
