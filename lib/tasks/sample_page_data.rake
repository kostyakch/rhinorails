namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Page.create!(name: "Главная страница",
                 slug: "index")
    99.times do |n|
      name  = Faker::Name.name
      slug = Faker::Base.flexible(name).downcase.gsub(' ', '-').gsub('.', '')
      Page.create!(name: name,
                   slug: slug)
    end
  end
end