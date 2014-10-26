import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
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
      , modMask = mod4Mask
      , terminal = "sakura"
      } `additionalKeys`
      [ ((mod4Mask .|. shiftMask, xK_s), spawn "sudo pm-suspend")
      , ((0                     , 0x1008FF11), spawn "~/.xmonad/volume/volumedown.sh")
      , ((0                     , 0x1008FF12), spawn "~/.xmonad/volume/mute.sh")
      , ((0                     , 0x1008FF13), spawn "~/.xmonad/volume/volumeup.sh")]
