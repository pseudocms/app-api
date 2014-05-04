def letter_boxed(*messages)
  box = "*" * 50
  puts box
  messages.each do |message|
    puts "* #{message}"
  end
  puts box
end

namespace :app do
  desc 'create a new oauth application - USAGE rake app:create NAME=app_name REDIR=redirect_uri'
  task :create do
    params = {
      name: ENV['NAME'] || 'dev application',
      redirect_uri: ENV['REDIR'] || 'http://localhost:3000/'
    }

    app = Doorkeeper::Application.create(params)
    if app.persisted?
      letter_boxed(
        "Successfully created the #{params[:name]} app!",
        "Client Id: #{app.uid}",
        "Client Secret: #{app.secret}"
      )
    else
      puts "Could not create the app!"
    end
  end
end
