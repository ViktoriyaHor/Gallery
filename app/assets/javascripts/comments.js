document.addEventListener("turbolinks:load", function() {
    $('#comments-link').click(function(){
       $('#comments-section').toggleClass('d-none d-block')
    });
});

