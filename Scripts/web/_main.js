
(function ($) {
    $(document).ready(function () {

        function focus() {
            $('.input100').each(function () {

                if ($(this).val().trim() != "") {
                    $(this).addClass('has-val');
                } else {
                    $(this).removeClass('has-val');
                }

            });
        }

        focus();

    });
})(jQuery);