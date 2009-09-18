class Notifier < ActionMailer::Base
  
  def demand(name, work, email, code)
    @recipients  = email
    @from        = "sam@designhou.se"
    @subject     = "How was it for you? Testify!"
    @sent_on     = Time.now
    @content_type = 'text/html'
    body[:name] = name
    body[:email] = email
    body[:code] = code
    body[:work] = work
    body[:link] = "http://testify.thecouriernew.com/go/#{code}"
  end

end
