module X86.SimAsm where

import X86.Loader
import X86.Machine
import X86.Simulator
import X86

--------------------------------------------------------------------------------
-- Simulator driver                                                           --
--------------------------------------------------------------------------------

{-

This file provides top-level drivers for your assembler, loader, and simulator.
Note: we assume that your Lab 4 solutions (or, eventually, our provided
assembler and loader) are in a file called Loader.hs.  If that file isn't
present, this will (obviously) not be as helpful.

-}

runtime =
 [ global "main"
   [ callq ~$$"function"
   , jmp ~$haltAddr ] ]

runtimef arg =
 [ global "main"
   [ movq ~$arg ~%RDI
   , callq ~$$"function"
   , jmp ~$haltAddr ] ]

simAsmNoArgs asm =
    eval $ load $ assemble (asm ++ runtime)

simAsmOneArg asm arg =
    eval $ load $ assemble (asm ++ runtimef arg)
