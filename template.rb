gem 'curation_concerns', '1.6.3'
gem 'geo_concerns', '0.1.1'

run 'bundle install'

generate 'curation_concerns:install', '-f'
generate 'geo_concerns:install', '-f'

rake 'db:migrate'
