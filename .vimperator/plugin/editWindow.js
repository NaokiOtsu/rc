/*
 * RTE (RichTextEditor) を外部エディタで編集するプラグイン
 * http://www.kevinroth.com/rte/demo.htm
 * などで試してみよう
 *
 * フォーカスしてから、<C-S-I> でエディタが立ち上がるはず。
 * もちろん 'editor' オプションがきちんと設定されていること
 */

let nsIR = Ci.nsIInterfaceRequestor;

let OUTPUT_SELECTION_ONLY = 1,
    OUTPUT_FORMATTED = 2,
    OUTPUT_RAW = 4,
    OUTPUT_BODYONLY = 8;

mappings.add([modes.NORMAL, modes.INSERT, modes.VISUAL, modes.TEXTAREA],
  ["<C-S-I>"], "edit window with externall editor",
  function () {
    if (config.isComposeWindow)
      editWindowExternally(GetCurrentEditorElement().contentWindow, true);
    else
      editWindowExternally();
  }, {});
function getEditingSession(win) {
  if (!win)
    win = document.commandDispatcher.focusedWindow;
  if (win instanceof Window) {
    return es = win.QueryInterface(nsIR)
                .getInterface(Ci.nsIWebNavigation)
                .QueryInterface(nsIR)
                .getInterface(Ci.nsIEditingSession);
  }
  return null;
}

function getEditorForWindow(win) {
  if (!(win instanceof Window))
    return null;
  let es = getEditingSession(win);
  if (es && es.windowIsEditable(win) &&
      util.computedStyle(win.document.body).getPropertyValue("-moz-user-modify") == "read-write")
    return es.getEditorForWindow(win);

  return null;
}

function editWindowExternally (win, forceText) {
  if (!options["editor"])
    return;
  if (!win)
    win = document.commandDispatcher.focusedWindow;
  let editor = getEditorForWindow(win);
  if (!editor) {
    commandline.echo("the window is not editable", commandline.HL_ERRORMSG, commandline.APPEND_TO_MESSAGES | commandline.DISALLOW_MULTILINE);
    return;
  }
  editor instanceof Ci.nsIPlaintextEditor;
  editor instanceof Ci.nsIHTMLEditor;

  let text = forceText ?
             editor.outputToString("text/plain", OUTPUT_FORMATTED) :
             editor.outputToString("text/html", OUTPUT_BODYONLY);
  try {
    let res = io.withTempFiles (function (tmpFile) {
      if (!tmpFile.write(text))
        throw Error("Input contains characters not valid in the current file encoding");

      modules.editor.editFileExternally(tmpFile.path);

      let val = tmpFile.read();

      editor.selectAll();
      editor.selection.deleteFromDocument();
      if (forceText) {
        editor.insertText(val);
      } else {
        let doc = editor.document;
        let htmlFragment = doc.implementation.createDocument(null, 'html', null);
        let range = doc.createRange();
        range.setStartAfter(doc.body);
        doc.body.appendChild(range.createContextualFragment(val));
      }
    }, this);
    if (res == false)
      throw Error("Couldn't create temporary file");
  } catch (e) {
    liberator.echoerr(e);
  }
}

// vim: sw=2 ts=2 et:
