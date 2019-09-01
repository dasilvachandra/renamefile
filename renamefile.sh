a=1;
b=$(ls | wc -l);
firstname=$1;
mkdir .temp
if [[ -z "$firstname" ]]; then
    firstname="";
fi
while (("$a" <= "$b" )); 
    do 
        
        format=$(ls | tail -n $a | head -n 1| grep -Eoi [.]+.+);
        from="$(ls | sort | tail -n $a | head -n 1 )";
        to=$(ls -lt --time-style="+%Y-%m-%d_%H%M%S($a)"| grep "$from" | tail -n $a | head -n 1 | awk '{print $6}');
        namefile=$firstname$to$format;
        if [[ -f $namefile ]]; then
            echo "$namefile exist"
            echo "rename file '$from' = $namefile";
        else 
            mv "$from" .temp/$namefile;
            echo "rename file '$from' = $namefile";
        fi
        a=$[$a+1];
    done;
mv .temp/* .
rm -r .temp