if false # Disable
  
if ENV['MONGOHQ_URL']
    MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
else
    config = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]
    uri = "mongodb://#{config['username']}:#{config['password']}@#{config['host']}:#{config['port']}/#{config['database']}"
    
    MongoMapper.config = {RAILS_ENV => {'uri' => uri}}
end

MongoMapper.connect(RAILS_ENV)

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end

end