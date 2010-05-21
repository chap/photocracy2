$(document).ready(function() {
	// this is how votes are cast
  $('a.vote').click(function(i){ 
    $.ajax({
      type: "post",
      url: $(this).attr('href') + '.js?locale=' + $(this).attr('locale'),
       dataType: "json",
       data: {
        'authenticity_token' : encodeURIComponent(AUTH_TOKEN),
        'prompt_id': $(this).attr('prompt_id'),
        // what is this?
        //'appearance_lookup': appearance_lookup
      },
      timeout: 5000,
      error: function(request, text, error) {
        alert(text);
      },
      success: function(data){
        alert('success!');
      }
    })
    return false;
  });
});