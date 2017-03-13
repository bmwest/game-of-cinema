$(document).ready(() => {
  $('.upvote').on("click", (event) => {
    event.preventDefault();

    let $this = $(this);
    let reviewId = $this.data('review_id');

    fetch(`http://localhost:3000/reviews/${reviewId}/votes`,
      {
        method: "POST",
        body: { value: 'upvote' }
      })
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        $('.total-votes-' + data.review_id ).html(data.votes_count);
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  });
})
