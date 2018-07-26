import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
-- import XMonad.Actions.Volume

xf86AudioLower, xf86AudioMute, xf86AudioPlay, xf86AudioRaise, xf86TouchpadToggle :: KeySym
xf86AudioLower = 0x1008ff11
xf86AudioMute = 0x1008ff12
xf86AudioPlay = 0x1008ff14
xf86AudioRaise = 0x1008ff13
xf86TouchpadToggle = 0x1008ffa9


main = do
     xmproc <- spawnPipe "xmobar"
     xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
	, layoutHook = avoidStruts  $  layoutHook defaultConfig
	, logHook = dynamicLogWithPP xmobarPP
	  	        { ppOutput = hPutStrLn xmproc
			, ppTitle = xmobarColor "green" "" . shorten 70
			}
	, modMask = mod4Mask -- Use Super instead of Alt
        --, terminal = "urxvt"
        } `additionalKeys`
	[ ((mod4Mask, xK_f), spawn "firefox")
	, ((mod4Mask, xK_e), spawn "emacs")
	, ((mod4Mask, xK_x), spawn "thunar")
	, ((mod4Mask, xK_t), spawn "thunderbird")
        , ((mod4Mask, xK_z), spawn "zim")
	-- , ((mod4Mask, xK_g), spawn "gedit")
	-- , ((mod4Mask, xK_c), spawn "chromium")
--        , ((0       , xf86AudioLower), lowerVolume 4 >> return ())
--        , ((0       , xf86AudioRaise), raiseVolume 4 >> return ())
	]

