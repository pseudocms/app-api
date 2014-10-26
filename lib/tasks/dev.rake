namespace :dev do

  namespace :sites do
    desc "create a site - USAGE rake dev:sites:create[NAME, OWNER_ID]"
    task :create, [:name, :owner_id] => :environment do |_, args|
      User.find(args[:owner_id]).owned_sites.create!(name: args[:name])
      puts "Created site[name: #{args[:name]}] for user[id: #{args[:owner_id]}]"
    end

    desc "create multiple sites - USAGE rake dev:sites:create_multiple[owner_id, N = 10]"
    task :create_multiple, [:owner_id, :n] => :environment do |_, args|
      count = [0, args[:n].to_i || 10].max
      task = Rake::Task["dev:sites:create"]

      puts "Creating #{count} sites..."
      count.times do
        task.invoke(Faker::Internet.domain_name, args[:owner_id])
        task.reenable
      end
    end
  end
end
