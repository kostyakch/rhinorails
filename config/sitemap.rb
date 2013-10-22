# Sitemap.configure do |config|
#   config.max_urls = 50
# end

Sitemap::Generator.instance.load :host => RhinoCMS::Application.config.action_mailer.default_url_options[:host] do

  path :root, 
    :priority => 1, 
    :change_frequency => "Daily",
    :updated_at => Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")

  Page.where('active = ? and publish_date <= NOW() and slug != "index"', true).each do |p|
    path :page, :skip_index => true, 
      :params => { :url => p.slug },
      :updated_at => p.updated_at.strftime("%Y-%m-%dT%H:%M:%S+00:00"),
      :change_frequency => "weekly",
      :priority => 0.3 if !p.parent || (p.parent && p.parent.active)      
  end
end

