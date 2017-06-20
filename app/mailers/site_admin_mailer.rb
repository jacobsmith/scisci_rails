class SiteAdminMailer < ActionMailer::Base
  default from: "head_researcher@citeandwrite.com"

  def custom(subject, msg)
    mail(to: 'jacob.wesley.smith@gmail.com', subject: subject, body: msg)  
  end
end
