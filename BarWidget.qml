import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "io.github.claudiuIosif.random-theme"

  readonly property string script: Qt.resolvedUrl("random-theme.sh").toString().replace(/^file:\/\//, "")
  property string currentTheme: ""

  function randomTheme() {
    if (root.bar) root.bar.run(root.script)
    else Quickshell.execDetached(["bash", root.script])
  }

  function showCurrentTheme() {
    if (root.bar) root.bar.run("omarchy-theme-current")
    else Quickshell.execDetached(["omarchy-theme-current"])
  }

  Process {
    id: themeProc
    command: ["omarchy", "theme", "current"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.currentTheme = (text || "").trim()
    }
  }

  Component.onCompleted: themeProc.running = true

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "✦"
    tooltipText: "Active theme: " + (root.currentTheme !== "" ? root.currentTheme : "…") + "\nClick for a random theme"
    onTooltipHoveredChanged: if (tooltipHovered) themeProc.running = true
    onPressed: function(pressedButton) {
      if (pressedButton === Qt.RightButton) root.showCurrentTheme()
      else root.randomTheme()
    }
  }
}
