#include <iostream>
#include <cstdlib>
//    ^ @keyword.import
//       ^ @string

auto main( int argc, char** argv ) -> int
// ^ @type.builtin
      //       ^ @variable.parameter
      //    ^ @type.builtin
      //    ^ @type.builtin
      //                  ^ @operator
{
    std::cout << "Hello world!" << std::endl;
    //  ^ @punctuation.delimiter
    
    return EXIT_SUCCESS;
    // ^ @keyword.return
    //      ^ @constant
}
