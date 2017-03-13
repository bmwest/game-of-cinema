class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review
   mail(
     to: review.theater.user.email,
     subject: "New Review for #{review.theater.name}"
   )
  end
end
