document.addEventListener("turbolinks:load", function() {

    $('#comments-link').click(function(){
       $('#comments-section').toggleClass('d-none d-block')
    });

    $("#form").validate({
        // focusCleanup: true,
        errorClass: 'is-invalid',
        errorElement: 'span',
        rules: {
            "comment[commenter]": 'required',
            "comment[body]": 'required',
        },
    });

});

