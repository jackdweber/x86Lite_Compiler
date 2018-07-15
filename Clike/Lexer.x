{

{-# LANGUAGE BangPatterns #-}
module Clike.Lexer where

import Data.Int

}

%wrapper "monad"

@numeric      = \-?[0-9]+
@identifier   = [A-Za-z_][0-9A-Za-z_]*

clike :-

<comment> "*/"     { skip `andBegin` 0 }
<comment> .        { skip }
<comment> \n       { skip }

<0> $white+        { skip }
<0> "//".*         { skip }
<0> "/*"           { skip `andBegin` comment  }

<0> "("            { nullaryToken TokLParen   }
<0> ")"            { nullaryToken TokRParen   }
<0> "{"            { nullaryToken TokLBrace   }
<0> "}"            { nullaryToken TokRBrace   }

<0> "=="           { nullaryToken TokEqEq     }
<0> "!="           { nullaryToken TokBangEq   }
<0> ">"            { nullaryToken TokGt       }
<0> ">="           { nullaryToken TokGte      }
<0> "<"            { nullaryToken TokLt       }
<0> "<="           { nullaryToken TokLte      }
<0> "."            { nullaryToken TokDot      }
<0> "="            { nullaryToken TokEquals   }
<0> "?"            { nullaryToken TokQuestion }
<0> ":"            { nullaryToken TokColon    }
<0> ","            { nullaryToken TokComma    }
<0> ";"            { nullaryToken TokSemi     }
<0> "+"            { nullaryToken TokPlus     }
<0> "-"            { nullaryToken TokMinus    }
<0> "*"            { nullaryToken TokStar     }
<0> "&"            { nullaryToken TokAmp      }
<0> "|"            { nullaryToken TokBar      }
<0> "~"            { nullaryToken TokTilde    }
<0> ">>>"          { nullaryToken TokAshr     }
<0> ">>"           { nullaryToken TokLshr     }
<0> "<<"           { nullaryToken TokShl      }

<0> int            { nullaryToken TokInt      }
<0> struct         { nullaryToken TokStruct   }
<0> if             { nullaryToken TokIf       }
<0> else           { nullaryToken TokElse     }
<0> while          { nullaryToken TokWhile    }
<0> break          { nullaryToken TokBreak    }
<0> continue       { nullaryToken TokContinue }
<0> return         { nullaryToken TokReturn   }

<0> @numeric       { token (\(_, _, _, str) len -> TokLiteral (read (take len str))) }
<0> @identifier    { token (\(_, _, _, str) len -> TokID (take len str)) }


{

--------------------------------------------------------------------------------

data Token

    = TokID String | TokLiteral Int64

    | TokDot | TokLParen | TokRParen | TokLBrace | TokRBrace
    | TokEquals | TokQuestion | TokColon | TokComma | TokSemi | TokEOF

    | TokEqEq | TokBangEq | TokLt | TokLte | TokGt | TokGte
    | TokPlus | TokMinus | TokStar | TokTilde | TokAmp | TokBar
    | TokShl | TokLshr | TokAshr

    | TokInt | TokStruct | TokIf | TokElse | TokWhile | TokBreak
    | TokContinue | TokReturn

  deriving (Eq, Show)

--------------------------------------------------------------------------------

nullaryToken t _ _ = return t
alexEOF = return TokEOF
lexwrap = (alexMonadScan >>=)
keepScanning = do t <- alexMonadScan
                  case t of
                    TokEOF -> return []
                    _ -> fmap (t :) keepScanning

}
