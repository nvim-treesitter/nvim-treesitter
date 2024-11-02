(comment) @comment @spell

(group_name) @markup.heading

(entry
  key: (identifier) @property)

(localized_key
  name: (identifier) @property)

[
  (language)
  (country)
  (encoding)
  (modifier)
] @string.special

(string) @string

(escape_sequence) @string.escape

(field_code) @character.special

[
  (true)
  (false)
] @boolean

"=" @operator

[
  ";"
  "_"
  "."
  "@"
] @punctuation.delimiter

[
  "["
  "]"
] @punctuation.bracket

; Especial entries
((entry
  key: (identifier) @_key
  value: (string) @type)
  (#eq? @_key "Type")
  (#any-of? @type "Application" "Link" "Directory"))

((entry
  key: (identifier) @_key
  value: (string) @number)
  (#eq? @_key "Version"))

((entry
  key: (identifier) @_key
  value: (string) @string.special.path)
  (#any-of? @_key "TryExec" "Path"))

((entry
  key: (identifier) @_key
  value: (string) @string.special.url)
  (#eq? @_key "URL"))

; https://specifications.freedesktop.org/menu-spec/latest/category-registry.html
((entry
  key: (identifier) @_key
  value: (list
    (string) @constant.builtin))
  (#eq? @_key "Categories")
  (#any-of? @constant.builtin
    ; Main categories
    "AudioVideo" "Audio" "Video" "Development" "Education" "Game" "Graphics" "Network" "Office"
    "Science" "Settings" "System" "Utility"
    ; Additional Categories
    "Building" "Debugger" "IDE" "GUIDesigner" "Profiling" "RevisionControl" "Translation" "Calendar"
    "ContactManagement" "Database" "Dictionary" "Chart" "Email" "Finance" "FlowChart" "PDA"
    "ProjectManagement" "Presentation" "Spreadsheet" "WordProcessor" "2DGraphics" "VectorGraphics"
    "RasterGraphics" "3DGraphics" "Scanning" "OCR" "Photography" "Publishing" "Viewer" "TextTools"
    "DesktopSettings" "HardwareSettings" "Printing" "PackageManager" "Dialup" "InstantMessaging"
    "Chat" "IRCClient" "Feed" "FileTransfer" "HamRadio" "News" "P2P" "RemoteAccess" "Telephony"
    "TelephonyTools" "VideoConference" "WebBrowser" "WebDevelopment" "Midi" "Mixer" "Sequencer"
    "Tuner" "TV" "AudioVideoEditing" "Player" "Recorder" "DiscBurning" "ActionGame" "AdventureGame"
    "ArcadeGame" "BoardGame" "BlocksGame" "CardGame" "KidsGame" "LogicGame" "RolePlaying" "Shooter"
    "Simulation" "SportsGame" "StrategyGame" "Art" "Construction" "Music" "Languages"
    "ArtificialIntelligence" "Astronomy" "Biology" "Chemistry" "ComputerScience" "DataVisualization"
    "Economy" "Electricity" "Geography" "Geology" "Geoscience" "History" "Humanities"
    "ImageProcessing" "Literature" "Maps" "Math" "NumericalAnalysis" "MedicalSoftware" "Physics"
    "Robotics" "Spirituality" "Sports" "ParallelComputing" "Amusement" "Archiving" "Compression"
    "Electronics" "Emulator" "Engineering" "FileTools" "FileManager" "TerminalEmulator" "Filesystem"
    "Monitor" "Security" "Accessibility" "Calculator" "Clock" "TextEditor" "Documentation" "Adult"
    "Core" "KDE" "COSMIC" "GNOME" "XFCE" "DDE" "GTK" "Qt" "Motif" "Java" "ConsoleOnly"
    ; Reserved
    "Screensaver" "TrayIcon" "Applet" "Shell"))
