# load all rb files directly under /lib
Dir[Rails.root + 'lib/*.rb'].each do |file|
  require file
end
