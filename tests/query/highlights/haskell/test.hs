{-# LANGUAGE QuasiQuotes #-}
-- ^ @preproc

module Main 
-- ^ @include
     -- ^ @namespace
  ( main
  ) where
   -- ^ @keyword

import Prelude hiding (show)
-- ^ @include
      -- ^ @namespace
              -- ^ @keyword
                      -- ^ @variable
import Data.Map (fromList)
      -- ^ @namespace
import qualified Data.Map as Map
                -- ^ @constructor
                           -- ^ @namespace
import qualified Chronos
                -- ^ @namespace

data ADT
-- ^ @keyword
  = A Int
 -- ^ @constructor
    -- ^ @type
  | B
 -- ^ @constructor
  deriving (Eq, Show)
  -- ^ @keyword
         -- ^ @type
               -- ^ @type

class Ord a => PartialOrd a
    -- ^ @type
       -- ^ @type
                -- ^ @type
                       -- ^ @type

instance Ord ADT where
      -- ^ @type
          -- ^ @type

newtype Rec
-- ^ @keyword
     -- ^ @type
  = Rec
  -- ^ @constructor
    { field :: Double
 -- ^ @punctuation.bracket
    -- ^ @field
              -- ^ @type
    }
 -- ^ @punctuation.bracket
    deriving Eq
           -- ^ @type

main :: IO ()
-- ^ @function
  -- ^ @operator
     -- ^ @type
         -- ^ @symbol
main = undefined
-- ^ @function
      -- ^ @exception

someFunc0 :: Int -> Int
              -- ^ @operator
someFunc0 x = someFunc1 x
       -- ^ @parameter
            -- ^ @function.call
  where
  -- ^ @keyword
    someFunc1 _ = 5
    -- ^ @function
               -- ^ @number

someInfix :: Integral a => a -> Double
            -- ^ @type
                   -- ^ @type
                      -- ^ @operator
                        -- ^ @type
someInfix x = fromIntegral x `myAdd` floatVal
                -- ^ @function.call
                        -- ^ @variable
                             -- ^ @operator
                                    -- ^ @variable
  where
    myAdd x y = x + y
             -- ^ @variable
                 -- ^ @variable
    floatVal = 5.5
    -- ^ @variable
            -- ^ @float

someIOaction :: IO ()
-- ^ @function
someIOaction = do
            -- ^ @keyword
  foo <- SomeModule.someFun <$> getArgs
-- ^ @variable
            -- ^ @namespace
                   -- ^ @function.call
                          -- ^ @operator
  let bar = SomeModule.doSomething $ "a" "b"
    -- ^ @variable
            -- ^ @namespace
                        -- ^ @function.call
                                -- ^ @operator
      func x y = x + y - 7
    -- ^ @function
        -- ^ @parameter
              -- ^ @variable
                  -- ^ @variable
  pure $ func 1 2
  -- ^ @function.call
        -- ^ @function.call

intVal :: Int
-- ^ @variable
intVal = 5
-- ^ @variable

mbInt :: Maybe Int
-- ^ @variable
mbInt = Just 5
-- ^ @variable

getLambda x = \y -> x `SomeModule.someInfix` y
            -- ^ @parameter
                      -- ^ @namespace
                                  -- ^ @operator

isVowel = (`elem` "AEIOU")
          -- ^ @operator
isVowelQualified = (`SomeModule.elem` "AEIOU")
                      -- ^ @namespace
                              -- ^ @operator

hasVowels = ("AEIOU" `elem`)
                   -- ^ @operator
hasVowelsQualified = ("AEIOU" `SomeModule.elem`)
                            -- ^ @namespace
                                       -- ^ @operator

quasiQuotedString = [qq|Some string|]
-- ^ @variable
                   -- ^ @function.call
                      -- ^ @string

higherOrderFn f x = f x
           -- ^ @function
             -- ^ @variable

composition f g = f . g
         -- ^ @function
           -- ^ @function
               -- ^ @function
                   -- ^ @function
