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
import qualified Chronos as C
                -- ^ @constructor
                         -- ^ @namespace
import FooMod (BarTy (barField))
                      -- ^ @field

x = mempty { field = 5 }
           -- ^ @field

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
mkA x = A x
       -- ^ @variable
mkAQualified x = SomeModule.A x
                           -- ^ @variable

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
recordWildCard Rec { field } = field
                    -- ^ @field
recordDotSyntax rec = rec.field
                        -- ^ @field


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
scopedTypeParam (x :: Int) = someFunc x
              -- ^ @parameter
scopedTypeParam (Just x :: Int) = someFunc x
                   -- ^ @parameter

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
    myAdd :: Num a => a -> a
    -- ^ @function
    myAdd x y = x + y
             -- ^ @variable
                 -- ^ @variable
    floatVal :: Double
    -- ^ @variable
    floatVal = 5.5
    -- ^ @variable
            -- ^ @float
    intVal :: Int
    -- ^ @variable
    intVal = getInt 5
    -- ^ @variable
    boolVal :: Bool
    -- ^ @variable
    boolVal = bool False True $ 1 + 2 == 3
    -- ^ @variable
    refVal = boolVal
    -- ^ @variable
    namespacedRecord = NS.Rec { field = bar }
    -- ^ @variable
    record = Rec { field = bar }
    -- ^ @variable
    constructorRef = A
    -- ^ @function
    isInt :: Either Double Int -> Bool
    -- ^ @function
    isInt eith@Left{} = False
        -- ^ @parameter
    isInt eith@(Left x) = False
    -- ^ @function
                  -- ^ @parameter
    isInt (Left x) = False
             -- ^ @parameter
    isInt (Right _) = True
    -- ^ @function

someIOaction :: IO ()
-- ^ @function
someIOaction = do
            -- ^ @keyword
  foo <- SomeModule.someFun <$> getArgs
-- ^ @variable
            -- ^ @namespace
                   -- ^ @function.call
                          -- ^ @operator
  _ <- someFunc0 =<< someIOAction
        -- ^ @function.call
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
      gunc x y = func x $ y + 7
                   -- ^ @variable
                       -- ^ @variable
  when foo $ putStrLn $ T.showt =<< bar
 -- ^ @function.call
     -- ^ @variable
            -- ^ @function.call
                        -- ^ @function.call

  pure $ func 1 2
  -- ^ @function.call
        -- ^ @function.call

intVal :: Int
intVal = 5
-- ^ @variable

intFun :: Int -> Int
intFun = 5
-- ^ @function

undefinedFun :: Int -> Int
undefinedFun = undefined
-- ^ @function

mbInt :: Maybe Int
-- ^ @variable
mbInt = Just 5
-- ^ @variable

tupleVal :: (a, b)
-- ^@variable
tupleVal = (1, "x")
-- ^@variable

listVal :: [a]
-- ^@variable
listVal = [1, 2]
-- ^@variable
-- ^@variable
condVal = if otherwise
-- ^@variable
            then False
            else True

getLambda x = \y -> x `SomeModule.someInfix` y
            -- ^ @parameter
                      -- ^ @namespace
                                  -- ^ @operator
lambdaTyped = \(y :: Int) -> x
             -- ^ @parameter
lambdaPattern = \(Just x) -> x
                    -- ^ @parameter
lambdaPatternTyped = \(Just x :: Int) -> x
                         -- ^ @parameter

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
quasiQuotedString2 = [SomeModule.qq|Some string|]
                        -- ^ @namespace
                              -- ^ @function.call

composition f g = f . g
               -- ^ @function
                   -- ^ @function
qualifiedComposition = SomeModule.f . SomeModule.g
                               -- ^ @function
                                              -- ^ @function
takeMVarOrThrow = evaluate <=< takeMVar
                  -- ^ @function
                              -- ^ @function
modifyMVarOrThrow v f = modifyMVar v $ f >=> evaluate
                                -- ^ @variable
                                    -- ^ @function
                                           -- ^ @function
assertNonEmpty xs = xs `shouldSatisfy` not . null
                 -- ^ @variable
                                     -- ^ @function
                                            -- ^ @function
appliedComposition f g var = (f . g) var
                           -- ^ @function.call
                               -- ^ @function.call
appliedComposition f g var = (NS.f . NS.g) var
                              -- ^ @function.call
                                     -- ^ @function.call
param1 |*| param2 = Qu $ param1 * param2
-- ^ @parameter
         -- ^ @parameter
(param1 :: Int) |*| (param2 :: Int) = Qu $ param1 * param2
-- ^ @parameter
                   -- ^ @parameter
(Qu a) |/| (SomeModule.Qu b) = a / b
 -- ^ @parameter
                       -- ^ @parameter
(Qu a :: Int) |/| (SomeModule.Qu b :: Int) = a / b
 -- ^ @parameter
                              -- ^ @parameter
(Qu a, b, c :: Int) |/| x = undefined
 -- ^ @parameter
    -- ^ @parameter
       -- ^ @parameter
[Qu a, b, c :: Int] >< x = undefined
 -- ^ @parameter
    -- ^ @parameter
       -- ^ @parameter
listParam [a, b :: Int, Just c] = undefined
        -- ^ @parameter
           -- ^ @parameter
                          -- ^ @parameter
tupleParam (a :: Int, b, Just c) = undefined
         -- ^ @parameter
                   -- ^ @parameter
                           -- ^ @parameter
listLambda = \[a, a :: Int, Just c] -> undefined
            -- ^ @parameter
               -- ^ @parameter
                              -- ^ @parameter
tupleLambda = \(a, b :: Int, Just c) -> undefined
             -- ^ @parameter
                -- ^ @parameter
nestedDestructure (Left (Just a)) = undefined
                           -- ^ @parameter
typeApplication x y = someFun @ty x y
                               -- ^ @variable
                                 -- ^ @variable
encrypt key pass = encrypt (defaultOAEPParams SHA1) key pass
                                                 -- ^ @variable
                                                      -- ^ @variable
recordUpdate x y rec = someFun rec {field = 5} (x, x) y
                                             -- ^ @variable
                                                   -- ^ @variable
viewPattern (func -> var) = 5
           -- ^ @function.call
                   -- ^ @parameter
g (func :: a -> b) x = func y
  -- ^ @parameter
  -- ^ @function
lambdaAlias :: LambdaAlias
lambdaAlias _ _ _ = undefined
  -- ^ @function
spec :: Spec
spec = describe "test ns" $ it "test case" pending
-- ^ @variable
