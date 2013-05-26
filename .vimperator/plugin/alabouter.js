liberator.modules.commands.addUserCommand(["alabouter"], "Alabouter",
    function(args) {
        var doc = content.document, loc = doc.location, timer;

        if ( ! doc.body ) {
            doc.addEventListener("DOMContentLoaded", replace);
        }

        function replace(element) {
            [].forEach.call(doc.querySelectorAll('a[target="_blank"]'), function(el) {
                el.setAttribute("href", el.textContent);
            });
        }

        doc.body.addEventListener("AutoPagerAfterInsert", function(evt) {
            if ( ! timer ) {
                timer = setTimeout(function() {
                    replace();
                    timer = void 0;
                }, 1000);
            }
        }, false);

        replace();
    }
);
