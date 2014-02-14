namespace :db do
  desc "Fill database with settings data"
  task populate: :environment do
  	Setting.create!(name: 'site_name', value: 'RhinoArt (change_me)', descr: 'Site name. Shown on title')
  	Setting.create!(name: 'disabled_pages', value: '01,02', descr: 'Pages iDs for disable pages')
  end

end
