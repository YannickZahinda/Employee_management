class UserMailer < ApplicationMailer
    default from: 'yannickzahinda442@gmail.com'

    def welcome_email(user, password)
        @user = user 
        @password = password 
        mail(to: @user.email, subject: 'Bienvenue au tableau de bord employés')
    end
end
