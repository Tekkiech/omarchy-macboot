import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "tekkiech.macboot"

  // Directory this plugin was loaded from, derived from this file's own URL
  // so it still resolves correctly if the plugin is symlinked in from
  // elsewhere rather than living directly under ~/.config/omarchy/plugins.
  readonly property string pluginDir: {
    var u = Qt.resolvedUrl(".").toString()
    return u.replace(/^file:\/\//, "").replace(/\/$/, "")
  }
  readonly property string scriptPath: pluginDir + "/bin/macboot"

  function launch() {
    if (root.bar) root.bar.run("omarchy-launch-floating-terminal-with-presentation " + Util.shellQuote(root.scriptPath))
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: ""
    // The Apple glyph's ink is noticeably shorter than its neighbors' at the
    // same point size in this Nerd Font (measured ~82px vs ~94px tall at
    // pointsize 100), and its thin silhouette (leaf, bite, stem) also reads
    // visually lighter than a solid glyph at matched height. The bar's icon
    // renderer only corrects horizontal centering, not per-glyph vertical
    // scale or visual weight, so bump the size past height-parity to
    // compensate — tuned by eye against the neighboring icons.
    fontSize: Math.round(Style.bar.iconFont * 1.2)
    tooltipText: "Switch boot target to macOS"
    onPressed: root.launch()
  }
}
