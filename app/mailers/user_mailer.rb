class UserMailer < ApplicationMailer
   default from: 'notifications@example.com'

   def order_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Order Confirmation Receipt')
  end
end
