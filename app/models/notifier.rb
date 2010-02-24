class Notifier < ActionMailer::Base
  
  def demand(demand)
    @recipients  = demand.email
    @from        = "shout@testifyapp.com"
    @subject     = "How was it for you? - Testify"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:demand] = demand
    body[:link] = "http://testifyapp.com/go/#{demand.code}"
  end
  
  def invite_reviewer(review, invite)
    @recipients = review.email
    @from = "shout@testifyapp.com"
    @subject = "Try out Testify"
    @sent_on = Time.now
    @content_type = 'text/html'
    body[:review] = review
    body[:link] = "http://testifyapp.com/signup/#{invite.code}"
  end
  
  def reminder(demand)
    @recipients  = demand.email
    @from        = "shout@testifyapp.com"
    @subject     = "How was it for you? - Testify"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:demand] = demand
    body[:link] = "http://testifyapp.com/go/#{demand.code}"
  end
  
  def review_completed(review)
    @recipients  = review.user.email
    @from        = "shout@testifyapp.com"
    @subject     = "You've been reviewed on Testify"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:review] = review
    body[:link] = "http://testifyapp.com/#{review.user.handle}"
  end
  
  def beta_invite(name, email, code)
    @recipients  = email
    @from        = "shout@testifyapp.com"
    @subject     = "Welcome to Testify"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:name] = name
    body[:code] = code
  end

end
