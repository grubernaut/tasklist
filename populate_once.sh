#!/bin/bash
RAILS_ENV=production rake app:populate_days
RAILS_ENV=production rake app:populate_weeks
RAILS_ENV=production rake app:populate_months
RAILS_ENV=production rake app:populate_biannuals
RAILS_ENV=production rake app:populate_years
