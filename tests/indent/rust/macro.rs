macro_rules! foo {
    ($a:ident, $b:ident, $c:ident) => {
        struct $a;
        struct $b;
    },
    ($a:ident) => {
        struct $a;
    },
}

foo! {
    A
}
