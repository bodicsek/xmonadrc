import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Actions.WindowGo (runOrRaise)
import System.IO

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/.xmobarrc"
  xmonad $ defaultConfig
      { manageHook = manageDocks <+> manageHook defaultConfig -- making space for a status bar
      , layoutHook = avoidStruts  $  layoutHook defaultConfig
      , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
      , startupHook = startup
      , modMask = mod4Mask
      , terminal = "sakura"
      } `additionalKeys`
      [ ((mod4Mask              , xK_s)      , spawn "sudo pm-suspend")
      , ((mod4Mask              , xK_q)      , spawn "killall dropbox nm-applet trayer" >> restart "xmonad" True)
      , ((0                     , 0x1008FF11), spawn "~/.xmonad/volume/volumedown.sh")
      , ((0                     , 0x1008FF12), spawn "~/.xmonad/volume/mute.sh")
      , ((0                     , 0x1008FF13), spawn "~/.xmonad/volume/volumeup.sh")]

startup = do
  spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x000000 --height 17 &"
  spawn "nm-applet &"
  spawn "dropbox start &"
