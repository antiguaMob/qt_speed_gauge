while true
do
	for((i=1;i<=120;i++))
	do
		a=$(printf "%02x" $i)
		echo $a
		cangen vcan0 -I 123 -D $a -L 1 -n 1 -g 50
	done
	for((i=120;i>=50;i--))
	do
		a=$(printf "%02x" $i)
		echo $a
		cangen vcan0 -I 123 -D $a -L 1 -n 1 -g 50
	done
	for((i=50;i<=120;i++))
	do
		a=$(printf "%02x" $i)
		echo $a
		cangen vcan0 -I 123 -D $a -L 1 -n 1 -g 50
	done
	for((i=120;i>=0;i--))
	do
		a=$(printf "%02x" $i)
		echo $a
		cangen vcan0 -I 123 -D $a -L 1 -n 1 -g 50
	done
done
