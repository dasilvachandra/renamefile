a=1;
b=$(ls | wc -l);
mkdir .temp
while (("$a" <= "$b" )); 
    do 
        format=$(ls | tail -n $a | head -n 1| grep -Eoi [.]+.+);
        from="$(ls | sort | tail -n $a | head -n 1 )";
        to=$(ls -lt --time-style="+%Y-%m-%d_%H%M%S($a)"| grep "$from" | tail -n $a | head -n 1 | awk '{print $6}');
        if [[ -f $to$format ]]; then
            echo "$to$format exist"
        else 
            mv "$from" .temp/$to$format;
            echo "rename file '$from' = $to$format";
        fi
        a=$[$a+1];
    done;
mv .temp/* .
rm -r .temp