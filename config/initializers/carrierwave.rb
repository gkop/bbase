# source http://socialmemorycomplex.net/2010/06/02/gridfs-with-mongoid-and-carrierwave-on-rails-3/

CarrierWave.configure do |config|
  config.grid_fs_database = Mongoid.database.name
  config.grid_fs_host = 'localhost'
  config.storage = :grid_fs
  config.grid_fs_access_url = "/images"
end
