When(/^I try to make a new project$/) do
  create_project
end

Then(/^I check if the project is made$/) do
  check_if_project_created
end


When(/^I make a new Prod environment$/) do
  create_prod_env
end

Then(/^I check if the Prod environment is made$/) do
  check_prod_env
end


When(/^I make a new Dev environment$/) do
  create_dev_env
end

Then(/^I check if the Dev environment is made$/) do
  check_dev_env
end

When(/^I add first global value$/) do
  add_global1
end

Then(/^I add second global value$/) do
  add_global2
end