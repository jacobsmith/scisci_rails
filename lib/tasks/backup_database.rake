task :backup_database do
  system('pg_dump scisci_production | gzip > /home/deployer/apps/scisci/current/log/backup_$(date +"%m_%d_%Y").pg_dump)')
end

task :upload_backup do
  AWS::S3::Base.establish_connection!(
  :access_key_id     => ENV['amazon_s3_key_id'], 
  :secret_access_key => ENV['amazon_s3_secret_key']
)

  file = system('ls -1 /home/deployer/apps/scisci/current/log/ | head -1')
  filename = file.scan(/\/[^\/]/).last.split("/").last
  AWS::S3::S3Object.store(filename, open(file), 'sciscibackup')
end
