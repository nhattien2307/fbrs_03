$(document).on('turbolinks:load', function() {
  $('.review-rating').raty({
    readOnly: true,
    score: function(){
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });

  $('.average_review-rating').raty({
    readOnly: true,
    path: '/assets/',
    score: function(){
      return $(this).attr('data-score');
    }
  });

  $('#rating-form').raty({
    path: '/assets/',
    scoreName: 'review[rate]'
  });
})
