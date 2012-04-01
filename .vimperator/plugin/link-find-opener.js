liberator.modules.commands.addUserCommand(["fi[nd]"], "find link and open it", 
    function(args) {
        var str = args[0];
        Array.prototype.forEach.call(
            content.document.querySelectorAll('a[href*=' + str + ']'),
            function(el) {
                liberator.open(el.getAttribute("href"), liberator.NEW_TAB);
            }
        );
    }
);
