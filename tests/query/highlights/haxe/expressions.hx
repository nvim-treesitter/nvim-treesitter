//conditional

if (true) {
// <- keyword
// ^ @punctuation.bracket
//  ^ constant  
//      ^ @punctuation.bracket
//        ^ @punctuation.bracket
  a = 1;
//^ variable
//    ^ number
}
// <- @punctuation.bracket

// parenthesis

a = (1+1);
// <- variable 
//  ^ @punctuation.bracket
//   ^ number  
//     ^ number 
//      ^ @punctuation.bracket

// unsafe cast
cast x;
// <- keyword 
//   ^ variable 

// safe cast
cast (x, Int);
// <- keyword 
//    ^ variable
//       ^ @type.builtin

// runtime type check
(x : Int);

// preprocessor macro
#if !condition
trace(x);
#elseif (condition > 2)
trace(y);
#else
trace(z);
#end
