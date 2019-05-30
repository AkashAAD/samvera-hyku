$(document).on('turbolinks:load',function(){
  $('#dataset_publication_year').datetimepicker({
    viewMode: 'years',
    format: 'MM/YYYY'
  });

  $('.dataset_reviewer_completing_due_date').datetimepicker();
  $('.dataset_reviewer_acceptance_due_date').datetimepicker();

  $(".open_youtube_modal").click(function(){

    var url = new URL($(this).attr('href'));
    var value = url.searchParams.get("v");

    $(".iframe_dataset_model").remove();
    $(".youtube-dataset-modal-title").append('<a class="iframe_dataset_model" href="' + $(this).attr('href') + '" target="_blank">' + $(this).attr('href') + '</a>');
    $('.youtube-dataset-modal-body').append('<iframe style="margin: 45px;" class="iframe_dataset_model" width="500" height="300" allowfullscreen="allowfullscreen"'+
      'mozallowfullscreen="mozallowfullscreen"' +
      'msallowfullscreen="msallowfullscreen"' + 
      'oallowfullscreen="oallowfullscreen"' +
      'webkitallowfullscreen="webkitallowfullscreen" src="https://www.youtube.com/embed/'+ value +'"></iframe>');
  });
});

