class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review
    mail(
      to: review.theater.user.email,
      subject: "New Review for #{review.theater.name}"
    )
  end

  def send_created_theater_email(user)
    @user = user
     mail(
      to: @user.email,
      subject: 'Thanks for adding a theater to our amazing app'
     )
  end
end
