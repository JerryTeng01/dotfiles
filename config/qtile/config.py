import os
import subprocess

from typing import List 

from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from gruvbox.gruvbox import *

triangle = "◀"
slash = ""
separator = slash

mod = "mod4"
terminal = "alacritty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "control"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "control"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "slash", lazy.spawn("rofi -theme gruvbox-dark-soft -show drun"), desc="Spawn rofi drun"),
    Key([mod], "f", lazy.spawn("rofi -theme gruvbox-dark-soft -show file-browser"), desc="Spawn rofi file-browser"),

    Key([mod], "b", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "n", lazy.spawn("firefox --private"), desc="Launch Firefox"),

    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -s set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -s set 10%-")),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -q set Master 10%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -q set Master 10%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -c 0 -q set Master toggle")),
]

group_names = [
        ("0", {'layout': 'monadtall'}),
        ("1", {'layout': 'monadtall'}),
        ("2", {'layout': 'monadtall'}),
        ("3", {'layout': 'monadtall'}),
        ("4", {'layout': 'monadtall'}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # switch to group i
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # send current window to group i

colors = {
    "lavender_web": "eeeeff",
    "old_lavender": "827081",
    "indian_yellow": "dda448",
    "eerie_black": "222222"
}

layout_theme = {
    "margin": 10,
    "border_focus": colors["lavender_web"],
    "border_normal": colors["eerie_black"],
    "border_width": 2
}

layouts = [
    layout.Columns(border_focus_stack='#d75f5f'),
    layout.Max(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='FiraCode',
    fontsize=16,
    padding=5,
    background=colors["eerie_black"],
    foreground=colors["lavender_web"]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    linewidth = 0,
                    padding = 10
                ),
                widget.GroupBox(
                    rounded = True,
                    disable_drag = True,
                    borderwidth = 1,
                    highlight_color = colors["old_lavender"],
                    highlight_method = "line",
                    active = colors["indian_yellow"],
                    inactive = colors["lavender_web"]
                ),
                widget.Prompt(
                    padding = 10
                ),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox(
                    text= 'vol:',
                    background=yellow,
                    foreground=white0,
                    ),
                widget.Volume(
                    background=yellow,
                    foreground=white0,
                ),
                widget.TextBox(
                    padding=0,
                    text= separator,
                    foreground=green,
                    background=yellow,
                ),
                widget.TextBox(
                    text="bat:",
                    background=green,
                    foreground=white0,
                ),
                widget.Battery(
                    format="{percent:2.0%}",
                    low_percentage=0.2,
                    #low_foreground=warning,
                    background=green,
                    foreground=white0,
                ),
                widget.TextBox(
                    padding=0,
                    text=separator,
                    foreground=aqua,
                    background=green,
                ),
                widget.Memory(
                    mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(terminal + " -e htop")}
                ),
                widget.TextBox(
                    padding=0,
                    text=separator,
                    foreground=purple,
                    background=blue,
                ),
                widget.Clock(
                    format="I:%M %p",
                    background=purple,
                    foreground=white0,
                ),
                widget.Systray(
                    background=purple,
                    icon_size=15,
                ),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])

wmname = "qtile"
