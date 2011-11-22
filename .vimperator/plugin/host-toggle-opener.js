let PLUGIN_INFO =
<VimperatorPlugin>
<name>fms_switcher</name>
<description>Open current location with different host</description>
<version>1.0.0</version>
<author>zentooo</author>
<license>Creative Commons</license>
<detail><![CDATA[
    == Subject ==
    This script allows you to open URL with different host quickly

    == Commands ==
    :host [hostname]
        toggle host of current location
]]></detail>
</VimperatorPlugin>;


liberator.modules.commands.addUserCommand(["ho[st]"], "open current location with different host", 
    function(args) {
        var host = args[0], loc = content.document.location;
        liberator.open(loc.href.replace(loc.host, host), liberator.NEW_TAB);
    },
    {
        completer: function(context, arg) {
            context.title = ["host", "comment"];
            context.completions = liberator.globalVariables.hosts || [];
        }
    }
);
