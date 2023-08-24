### Gnome desktop: zenity

### KDE plasma desktop: kdialog

# Yes/no dialog: exit status 0/1 indicates yes/no
kdialog --yesno "Are you hungry for apples?"
echo $?

# Text input box: input goes to stdout
result=$(kdialog --textinputbox "Tell me a secret." "I can't live without coffee!")
echo $result

# Display sorry message
kdialog --sorry "We're sorry."

# Choose colour: returns colour hex code to stdout
result=$(kdialog --color)

# Choose date: returns date to stdout
result=$(kdialog --calendar "When are you free?")


# See
# > kdialog 
# Usage: kdialog [options] [arg]
# KDialog can be used to show nice dialogue boxes from shell scripts
# 
# Options:
#   -h, --help                        Displays help on commandline options.
#   --help-all                        Displays help including Qt specific
#                                     options.
#   -v, --version                     Displays version information.
#   --author                          Show author information.
#   --license                         Show licence information.
#   --desktopfile <file name>         The base file name of the desktop entry for
#                                     this application.
#   --yesno <text>                    Question message box with yes/no buttons
#   --yesnocancel <text>              Question message box with yes/no/cancel
#                                     buttons
#   --warningyesno <text>             Warning message box with yes/no buttons
#   --warningcontinuecancel <text>    Warning message box with continue/cancel
#                                     buttons
#   --warningyesnocancel <text>       Warning message box with yes/no/cancel
#                                     buttons
#   --ok-label <text>                 Use text as OK button label
#   --yes-label <text>                Use text as Yes button label
#   --no-label <text>                 Use text as No button label
#   --cancel-label <text>             Use text as Cancel button label
#   --continue-label <text>           Use text as Continue button label
#   --sorry <text>                    'Sorry' message box
#   --detailedsorry <text> <details>  'Sorry' message box with expandable Details
#                                     field
#   --error <text>                    'Error' message box
#   --detailederror <text> <details>  'Error' message box with expandable Details
#                                     field
#   --msgbox <text>                   Message Box dialogue
#   --inputbox <text> <init>          Input Box dialogue
#   --imgbox <file>                   Image Box dialogue
#   --imginputbox <file> <text>       Image Box Input dialogue
#   --password <text>                 Password dialogue
#   --newpassword <text>              New Password dialogue
#   --textbox <file>                  Text Box dialogue
#   --textinputbox <text> <init>      Text Input Box dialogue
#   --combobox <text>                 ComboBox dialogue
#   --menu <text>                     Menu dialogue
#   --checklist <text>                Check List dialogue
#   --radiolist <text>                Radio List dialogue
#   --passivepopup <text> <timeout>   Passive Popup
#   --icon <icon>                     Popup icon
#   --getopenfilename                 File dialogue to open an existing file
#                                     (arguments [startDir] [filter])
#   --getsavefilename                 File dialogue to save a file (arguments
#                                     [startDir] [filter])
#   --getexistingdirectory            File dialogue to select an existing
#                                     directory (arguments [startDir])
#   --getopenurl                      File dialogue to open an existing URL
#                                     (arguments [startDir] [filter])
#   --getsaveurl                      File dialogue to save a URL (arguments
#                                     [startDir] [filter])
#   --geticon                         Icon chooser dialogue (arguments [group]
#                                     [context])
#   --progressbar <text>              Progress bar dialogue, returns a D-Bus
#                                     reference for communication
#   --getcolor                        Colour dialogue to select a colour
#   --format <text>                   Allow --getcolor to specify output format
#   --title <text>                    Dialogue title
#   --default <text>                  Default entry to use for combobox, menu,
#                                     colour, and calendar
#   --multiple                        Allows the --getopenurl and
#                                     --getopenfilename options to return multiple
#                                     files
#   --separate-output                 Return list items on separate lines (for
#                                     checklist option and file open with
#                                     --multiple)
#   --print-winid                     Outputs the winID of each dialogue
#   --dontagain <file:entry>          Config file and option name for saving the
#                                     "do-not-show/ask-again" state
#   --slider <text>                   Slider dialogue box, returns selected value
#   --dateformat <text>               Date format for calendar result and/or
#                                     default value (Qt-style); defaults to 'ddd
#                                     MMM yyyy'
#   --calendar <text>                 Calendar dialogue box, returns selected
#                                     date
#   --attach <winid>                  Makes the dialogue transient for an X app
#                                     specified by winID
#   --embed <winid>                   A synonym for --attach
#   --geometry <geometry>             Dialogue geometry:
#                                     [=][<width>{xX}<height>][{+-}<xoffset>{+-}<y
#                                     offset>]
# 
# Arguments:
#   [arg]                             Arguments - depending on main option