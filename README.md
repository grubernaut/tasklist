# TaskList 
Tasklist is a feature-full rails app, that tracks Daily, Weekly, Monthly, Bi-Anually, and
Yearly reoccuring tasks for log purposes such as business audits. 

Tasklist sends Daily Snapshot Emails as well as a Weekly Checkup Email of any tasks that
have yet to be completed. 
Tasklist also has Slack integration to allow it to post to a specific channel in Slack as
well as sending Mail messages. 

Use and dependence on the [Whenever](https://github.com/javan/whenever) gem allows for
Rake tasks to be scheduled as Cron Jobs to automagically populate the database columns
with the reoccuring tasks needed to be completed. 

Tasklist uses LDAP Authentication via
[devise_ldap_authenticatable](https://github.com/cschiewek/devise_ldap_autheticatable) for
auth access to the entire app. LDAP access also adds blame for which user completed which
task or not, necessary information for any audit situation. 

## Installation
- Clone, Install RVM Ruby 2.1.0 and Rails 4.0.2
- Move config/database.yml.template to config/database.yml and configure as needed. 
- Move config/application.yml.template to config/application.yml and configure as needed. 
- bundle install
- rake db:setup (with proper rails environment set of course)
- Edit each Rake Task lib/tasks/{dailies,weeks,months,biannuals,years} with the correct
  tasks that need to be completed. 
- Run the ./populate_once.sh script to populate the columns with initial values. 
```bash
$ cd RAILS_ROOT; ./populate_once.sh
```

- Install Devise, without over-writing any configuration files:
```ruby
	rails g devise:install
```

- Generate Devise LDAP Authenticatable: 
```ruby
	rails g devise_ldap_authenticatable:install
```

- Edit the generated config/ldap.yml config file as needed to provide correct LDAP
  parameters for the devise gem. 
- Profit? 


## Configuration
Tasklist uses the Figaro gem to maintain a clean application environment while allowing
configuration from a single file. Configure config/application.yml fully in order to fully
configure the application. 

With Devise and LDAP, the config file for LDAP is config/ldap.yml

## Gems Included 
<ul>
	<li>Rails 4.0.2</li>
	<li>mysql</li>
	<li>sass-rails</li>
	<li>uglifier >=1.3.0</li>
	<li>coffee-rails</li>
	<li>jquery-rails</li>
	<li>turbolinks</li>
	<li>jbuilder</li>
	<li>devise</li>
	<li>devise_ldap_authenticatable</li>
	<li>devise-encryptable</li>
	<li>twitter-bootstrap-rails</li>
	<li>therubyracer</li>
	<li>less-rails</li>
	<li>bootstrap-sass</li>
	<li>rails_layout</li>
	<li>whenever</li>
	<li>will_paginate</li>
	<li>figaro</li>
	<li>json</li>
	<li>minitest</li>
</ul>

## TODO - Items
<ul>
	<li>Report Generator</li>
	<li>iOS / Android / Mobile Views</li>
	<li>Many more that I haven't thought of yet...</li>
</ul>

## Completed TODO Items: 
<ul>
	<li>Authentication Bug on Password Change</li>
</ul>

## Contact Me 
Jake Champlin - jake.champlin.27[at]gmail.com

[Twitter](https://twitter.com/grubernaut)
