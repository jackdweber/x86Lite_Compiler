module X86.Machine where

import Data.Bits
import Data.Array.IArray
import Data.Int
import Data.Word
import System.IO
import X86


--------------------------------------------------------------------------------
-- Simulator-specific types and values                                        --
--------------------------------------------------------------------------------

{-

The in-memory representation of x86 instructions is particularly involved.
Rather than attempting to reproduce it for our simulator, we will use a
simplified representation of memory in which instructions uniformly take four
bytes, and are stored as Haskell values rather than as binary encodings.  The
`SByte` (simulator byte) data type implements this abstraction.  The `Inst` case
represents the first byte of an instruction, and contains the Haskell
representation of the instruction The `More` case is used to fill the remaining
three bytes that would contain the remainder of the representation.  So, for
example, the instruction stream

   [ (Movq, [Reg RBX, Reg RAX])
   , (Retq, []) ]

would be represented by the SByte sequence

   [ Inst (Movq, [Reg RBX, Reg RAX]), More, More, More
   , Inst (Retq, []), More, More, More ]

There is no need to similarly abstract our view of data, so the final
constructor of the `SByte` type, `Byte`, is used to store one byte of data.

-}

data SByte = Inst MachineInstr | More | Byte Word8
  deriving (Read, Show)

{-

While our model of x86 could potentially address values anywhere in memory, we
don't expect to actually need very much memory for any programs we will be
compiling.  So, we somewhat arbitrarily set the following limits for the amount
of memory actually provided by the simulator.  (Among other things, this avoids
any difficulties with representing large amounts of memory in Haskell.)

-}

memoryFloor = 0x400000
memoryCeiling = 0x410000

{-

Typically, the end of program execution involves some interaction between the
program and the operating system.  We will take a simpler view here---when a
program is finished executing, it jumps to a given address outside the range of
memory.  This will signal to the simulator that it is done executing.

-}

haltAddr = 0xDEAD

{-

We represent the simulated machine by a combination of its memory,
(general-purpose) registers, and the special flags and IP registers.

-}

data Machine =
    M { mem :: Array Int64 SByte
      , regs :: Array Register Int64
      , flags :: (Bool, Bool, Bool)
      , rip :: Int64 }
  deriving (Read, Show)

zeroMachine :: Machine
zeroMachine =
    M { mem = listArray (memoryFloor, memoryCeiling) (repeat (Byte 0))
      , regs = listArray (RAX, R15) (repeat 0)
      , flags = (False, False, False)
      , rip = haltAddr }

getMemory :: Int64 -> Machine -> SByte
getMemory addr m = mem m ! addr

setMemory :: Int64 -> SByte -> Machine -> Machine
setMemory addr val m = m{ mem = mem m // [(addr, val)] }

getRegister :: Register -> Machine -> Int64
getRegister reg m = regs m ! reg

setRegister :: Register -> Int64 -> Machine -> Machine
setRegister reg val m = m{ regs = regs m // [(reg, val)] }

getOF, getZF, getSF :: Machine -> Bool
getOF m = overflow
    where (overflow, _, _) = flags m
getZF m = zero
    where (_, zero, _) = flags m
getSF m = sign
    where (_, _, sign) = flags m

setOF, setZF, setSF :: Bool -> Machine -> Machine
setOF b m = m{ flags = (b, zero, sign) }
    where (overflow, zero, sign) = flags m
setZF b m = m{ flags = (overflow, b, sign) }
    where (overflow, zero, sign) = flags m
setSF b m = m{ flags = (overflow, zero, b) }
    where (overflow, zero, sign) = flags m

clearFlags :: Machine -> Machine
clearFlags m = m{ flags = (False, False, False) }

getRIP :: Machine -> Int64
getRIP = rip

setRIP :: Int64 -> Machine -> Machine
setRIP val m = m{ rip = val }

--------------------------------------------------------------------------------
-- Convenience functions                                                      --
--------------------------------------------------------------------------------

fromBytes :: [Word8] -> Int64
fromBytes bs = foldr f 0 bs
    where f b c = shiftL c 8 .|. fromIntegral b

fromQuad :: Int64 -> [Word8]
fromQuad i = [byteAt j | j <- [0..7]]
    where byteAt j = fromIntegral $ i `shiftR` (fromIntegral j * 8) .&. 255

readMachine :: FilePath -> IO Machine
readMachine file = read `fmap` readFile file

writeMachine :: FilePath -> Machine -> IO ()
writeMachine file m = writeFile file (show m)
