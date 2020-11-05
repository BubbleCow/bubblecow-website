class ApplicationMailer < ActionMailer::Base
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@bubblcow.com"
  default from: 'gary@bubblecow.com'
  layout 'mailer'
end
