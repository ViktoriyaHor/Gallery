document.addEventListener("turbolinks:load", function() {
    // create references to the modal...
    var modal = document.getElementById('myModal');
    // to all images -- note I'm using a class!
    var images = document.getElementsByClassName('images');
    // the image in the modal
    var modalImg = document.getElementById("img-modal");

    if (modal!=null) {

        // Go through all of the images with our custom class
        for (var i = 0; i < images.length; i++) {
            var img = images[i];
            img.style.cursor = "zoom-in";
            // and attach our click listener for this image.

            img.onclick = function () {
                modal.style.display = "block";
                modalImg.src = this.getAttribute("data-src");
            }
        }

        var span = document.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        };
        modal.onclick = function () {
            modal.style.display = "none";
        };
    }
});
