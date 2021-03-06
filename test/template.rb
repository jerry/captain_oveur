run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/images/rails.png'

gem 'cucumber', :env => [:cucumber] 
gem 'cucumber-rails', :env => [:cucumber] 
gem 'database_cleaner', :env => [:cucumber] 
gem 'webrat', :env => [:cucumber] 
gem 'rspec', :env => [:cucumber] 
gem 'rspec-rails', :env => [:cucumber] 
gem "factory_girl", :env => [:cucumber] 
gem "launchy", :env => [:cucumber] 

gem 'captain_oveur' 
gem 'clearance', :version => "=0.8.8"


# Install gems on local system
rake('gems:install')
#rake('db:create:all')
#generate("rspec")
generate(:controller, "home", "index")

route "map.root :controller => 'home'"


generate(:cucumber, "--force --webrat")

file 'app/views/layouts/home.html.erb', <<-CODE
<div id="flash">
  <% flash.each do |key, value| -%>
    <div id="flash_<%= key %>"><%=h value %></div>
  <% end -%>
</div>
<%= yield %>
CODE



generate(:clearance, "-f")
rake('db:migrate')
generate(:captain_oveur)
rake('db:migrate')
generate(:clearance_features, "-f")
generate(:captain_oveur_features, "-f")
rake('db:test:prepare')
rake('log:clear')
