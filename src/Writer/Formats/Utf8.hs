-----------------------------------------------------------------------------
-- |
-- Module      :  Writer.Formats.Utf8
-- License     :  MIT (see the LICENSE file)
-- Maintainer  :  Felix Klein (klein@react.uni-saarland.de)
-- 
-- Transforms a specification to a UTF8 string.
-- 
-----------------------------------------------------------------------------

module Writer.Formats.Utf8
    ( writeUtf8
    ) where

-----------------------------------------------------------------------------

import Config
import Simplify

import Data.Error
import Data.Specification

import Writer.Eval
import Writer.Data
import Writer.Utils

-----------------------------------------------------------------------------

opNames
  :: OperatorNames

opNames = OperatorNames
  { opTrue = "⊤" 
  , opFalse = "⊥"
  , opNot = "¬" 
  , opAnd = "∧" 
  , opOr = "∨" 
  , opImplies = "→" 
  , opEquiv = "↔" 
  , opNext = "◯" 
  , opFinally = "◇"
  , opGlobally = "□" 
  , opUntil = "U" 
  , opRelease = "R" 
  , opWeak = "W"
  }

-----------------------------------------------------------------------------

-- | UTF8 writer.

writeUtf8
  :: Configuration -> Specification -> Either Error String

writeUtf8 c s = do
  (as,is,gs) <- eval c s
  fml0 <- merge as is gs
  fml1 <- simplify c fml0
    
  return $ pretty (outputMode c) opNames fml1

-----------------------------------------------------------------------------

