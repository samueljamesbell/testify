namespace :mailer do
  desc "Remind people of outstanding demands for reviews."
    task(:remind => :environment) do
    demands = Demand.find(:all, :conditions => { :completed => false })
    for demand in demands
      puts demand.name
      Notifier.deliver_reminder(demand.name, demand.work, demand.email, demand.code)
    end
    puts "Done."
  end
end
