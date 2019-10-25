document.addEventListener("turbolinks:load", function() {
    // create references to the modal...
    let modal = document.getElementById('myModal');
    // to all images -- note I'm using a class!
    let images = document.getElementsByClassName('images');
    // the image in the modal
    let modalImg = document.getElementById("img-modal");

    if (modal!=null) {

        // Go through all of the images with our custom class
        for (let i = 0; i < images.length; i++) {
            let img = images[i];
            img.style.cursor = "zoom-in";
            // and attach our click listener for this image.

            img.onclick = function () {
                modal.style.display = "block";
                modalImg.src = this.getAttribute("data-src");
            }
        }

        let span = document.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        };
        modal.onclick = function () {
            modal.style.display = "none";
        };
    }
});
