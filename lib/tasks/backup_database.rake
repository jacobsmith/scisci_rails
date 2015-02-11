require 'pry'

task :backup_database do
  system('pg_dump scisci_production | gzip > /home/deployer/apps/scisci/current/log/backup_$(date +"%m_%d_%Y").pg_dump')
end

task :upload_backup do
  binding.pry
  AWS::S3::Base.establish_connection!(
  :access_key_id     => ENV['amazon_s3_key_id'], 
  :secret_access_key => ENV['amazon_s3_secret_key']
)

  file = Dir.glob("/home/deployer/apps/scisci/current/log/backup_*").max_by { |f| File.mtime(f) }.split("/").last
  AWS::S3::S3Object.store(file, open(file), 'sciscibackup')
end
