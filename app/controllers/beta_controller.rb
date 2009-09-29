class BetaController < ApplicationController
	before_filter :ensure_admin
	
	def invite
	end
	
	def process_invite
    @name = params[:name]
    @email = params[:email]
    @code = Invite.create!
    Notifier.deliver_beta_invite(@name, @email, @code.code)
    flash[:success] = 'Invite has been sent.'
    redirect_to :action => 'invite'
  end
  
end
