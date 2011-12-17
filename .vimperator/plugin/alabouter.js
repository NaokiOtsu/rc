let PLUGIN_INFO =
<VimperatorPlugin>
<name>alabouter</name>
<description>Alabouter</description>
<version>1.0.0</version>
<author>zentooo</author>
<license>Creative Commons</license>
<detail><![CDATA[
    == Subject ==
    This is the Alabouter.

    == Commands ==
    :alabouter
]]></detail>
</VimperatorPlugin>;


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
