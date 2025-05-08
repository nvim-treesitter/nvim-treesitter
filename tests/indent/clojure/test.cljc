(identity
  true)

(:k
 {:k 1})

(+
  1
  2)

(
  +
  1
  2)

(let [a 1
      b 2]
  true)

[1 2 3
 4 5 6]

{:a 1
 :b 2}

{
 :a 1
 :b 2}

#:a
 {:a 1
  :b 2}

#{1 2
  3 4}

#{
  1 2
  3 4}

(defn
  _
  []
  true)

(defn _
  []
  true)

(defn _
  [a
   b]
  true)

(defn _ [a
         b]
  true)

(defn _ [
         a]
  true)

(defn _ [{a :a
          b :b}]
  true)

(defn _ 
  ([x]
   true) 
  ([x
    y]
   true))

#(*
   %1 
   %2)

#(
   *
   %1 
   %2)

#?(
   :clj (+ 1 1))

#?@(
    :clj (+ 1 1))

'
 ()

`
 ()

~
 ()

#a
 ()

@
 (atom nil)

~@
  ()

#'
  ()

#_
  ()

#=
  ()

'#=
   (+ 1 1)

^:a
(+ 1
  2 3)

^:a
[1 2
 3 4]

^:a
{:a 1
 :b 2}

^:a
^[1 2 (+
        1 2)
  3 4]
^{:a 1
  :b 2}
{}
