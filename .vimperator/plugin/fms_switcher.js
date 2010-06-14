let PLUGIN_INFO =
<VimperatorPlugin>
<name>fms_switcher</name>
<description>This script allows you to switch FireMobileSimulator status with Vimp CLI.</description>
<version>1.0.0</version>
<author>zentooo</author>
<license>Creative Commons</license>
<detail><![CDATA[
    == Subject ==
    This script allows you to switch FireMobileSimulator status from Vimperator CLI.

    == Commands ==
    :fms off:
        turn off FireMobileSimulator's mobile emulation.
    :fms [deviceName]:
        turn on FireMobileSimulator's mobile emulation with given deviceName.
]]></detail>
</VimperatorPlugin>;


liberator.modules.commands.addUserCommand(
  ["fms"],
  "Switch FireMobileSimulator status",
  function(args){
    var deviceName = args[0];

    if (deviceName == "off") {
      firemobilesimulator.core.resetDevice();
      return;
    }

    var deviceList = firemobilesimulator.common.pref.getListPref("msim.devicelist", ["label"]);
    var deviceIndex = deviceList.map(function(item) { return item.label } ).indexOf(deviceName);

    if (deviceIndex != -1) {
      firemobilesimulator.core.setDevice(deviceIndex + 1);
    }
    else {
      liberator.echoerr('Unsupported fms command: ' + deviceName);
    }
  },
  {
    completer: function(context, arg) {
      context.title = ["Option", "User Agent"];
      
      var suggestions = firemobilesimulator.common.pref.getListPref("msim.devicelist", ["label", "useragent"]).map(function(item) { return [item.label, item.useragent]; });

      suggestions.push(["off", "disable FireMobileSimulator"]);

      context.completions = suggestions;
    }
  }
);
