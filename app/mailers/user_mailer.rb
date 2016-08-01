class UserMailer < ApplicationMailer

   default from: 'notifications@example.com'

   def order_email(order)
    @user = order.email
    @order = order
    @url  = 'http://example.com/login'
    mail(to: @user, subject: 'Order Confirmation Receipt')
  end
end
