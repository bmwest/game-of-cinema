$('.upvote').on('click', function(e) {
   e.preventDefault();

   var $this = $(this);
   var reviewId = $this.data('reviewid');

   var request = $.ajax({
      method: "POST",
      url: '/reviews/' + reviewId + '/votes',
      data: { value: "upvote" }
    });

    request.done(function(data) {
      $('#upvotes-' + data.review_id ).html("Upvotes: " + data.upvotes);
      $('#downvotes-' + data.review_id ).html("Downvotes: "+ data.downvotes);
    });
  });

$('.downvote').on('click', function(e) {
   e.preventDefault();

   var $this = $(this);
   var reviewId = $this.data('reviewid');

   var request = $.ajax({
      method: "POST",
      url: '/reviews/' + reviewId + '/votes',
      data: { value: "downvote" }
    });

    request.done(function(data) {
      $('#upvotes-' + data.review_id ).html("Upvotes: " + data.upvotes);
      $('#downvotes-' + data.review_id ).html("Downvotes: "+ data.downvotes);
    });
  });
