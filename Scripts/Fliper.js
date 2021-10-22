
var images = ["01.jpg", "02.jpg", "03.jpg", "04.jpg", "05.jpg", "06.jpg", "07.jpg", "08.jpg", "09.jpg", "10.jpg"];
$(function () {
    var i = 0;
    //$(".login100-more").css("background-image", "url(../../Images/Home/" + images[i] + ")");
    $(".login100-more").css("background-image", "url(http://192.168.0.230/ctanew/slider/" + images[i] + ")");
    setInterval(function () {
        i++;
        if (i == images.length) {
            i = 0;
        }
        $(".login100-more").fadeOut("slow", function () {
            //$(this).css("background-image", "url(../../Images/Home/" + images[i] + ")");
            $(this).css("background-image", "url(http://192.168.0.230/ctanew/slider/" + images[i] + ")");
            $(this).fadeIn("slow");
        });
    }, 5000);
});