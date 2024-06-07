<?php

class Foo
{
    private string $_baz;

    public string $baz {
        &get => $this->_baz;
        set {
            $this->_baz = strtoupper($value);
        }
    }
}
