liberator.modules.commands.addUserCommand(
    ["gms"],
    "Switch Gmail Account",
    function(args) {
        liberator.open(args[0]);
    },
    {
        completer: function(context, arg) {
            var doc = content.document.getElementById("canvas_frame").contentWindow.document;

            context.title = ["url", "account"];
            context.completions = Array.prototype.map.call(
                doc.querySelectorAll("a.gbmpl.gbmt"),
                function(el) {
                    return [el.getAttribute("href"), el.querySelector("span.gbmpmn").innerHTML];
                }
            );
        }
    }
);
