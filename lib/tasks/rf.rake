namespace :rf do
  desc "Launches rails server and faye"
  task :s => :environment do
    `rails s && rackup private_pub.ru -s thin -E production`
    puts $stdout
  end
  task :faye do
    `rackup private_pub.ru -s thin -E production`
  end
end
