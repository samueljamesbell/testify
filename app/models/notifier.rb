class Notifier < ActionMailer::Base
  
  def demand(name, work, email, code)
    @recipients  = email
    @from        = "shout@testifyapp.com"
    @subject     = "How was it for you? Testify!"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:name] = name
    body[:email] = email
    body[:code] = code
    body[:work] = work
    body[:link] = "http://testifyapp.com/go/#{code}"
  end
  
  def reminder(name, work, email, code)
    @recipients  = email
    @from        = "shout@testifyapp.com"
    @subject     = "How was it for you? Testify!"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:name] = name
    body[:email] = email
    body[:code] = code
    body[:work] = work
    body[:link] = "http://testifyapp.com/go/#{code}"
  end
  
  def review_completed(name, work, email, handle)
    @recipients  = email
    @from        = "shout@testifyapp.com"
    @subject     = "You've been reviewed on Testify!"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:name] = name
    body[:handle] = handle
    body[:work] = work
    body[:link] = "http://testifyapp.com/#{handle}"
  end

end
