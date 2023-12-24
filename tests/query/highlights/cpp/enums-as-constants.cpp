enum class Foo{
    a,
//  ^ @constant
    aa,
//  ^ @constant
    C,
//  ^ @constant
};

void foo(Foo f){
    switch ( f ) {
        case Foo::a:
         //  ^ @type
         //   ^ @module
         //       ^ @constant
            break;
        case Foo::aa:
         //        ^ @constant
            break;
        case Foo::C:
         //       ^ @constant
            break;
        default:
    }
}
