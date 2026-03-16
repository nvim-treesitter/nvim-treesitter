for i in 1 2 3; do
    if [[ true ]]; then
        echo "asd"
    elif [ true ]; then
        echo "dsa"
    else
        echo ""
    fi
    echo $i
done

while true; do
    break
done

case $foo in
    a) echo a ;;
    b) echo b ;;
esac

function x() {
    echo x
}

y() {
    echo y
}

{
    echo z
}

(
    echo subshell
)

A=$(
    echo command substitution
)
