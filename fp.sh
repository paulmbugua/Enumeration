function filefunction {
locate $f
file $f
cat $f
}

function listfiles {
echo "En"
ls -al 
}

function installfunction {
echo "Enter the file name eg(<filename>.<extension>)"
read f
filefunction
ext=$(echo "$f" | cut -d'.' -f 2)

	if [[ $ext == "sh" ]]
	then
		echo "This is a script"
		chmod +x $f
		./$f
		
	elif [[ $ext == "py" ]]
	then 
		echo "This is a py file "
		chmod +x $f
		python $f
	elif [[ $ext == "c" ]]
	then 
		echo "This is a c file "
		echo "compiling the file..."
		out=$(echo "$f" | cut -d'.' -f 1)
		gcc -o $out $f
		echo "running the file.."
		chmod +x $out
		./$out
	
	elif [[ $ext == "run" ]]
	then 
		echo "This is a run file "
		chmod +x $f
		./$f
	elif [[ $ext == "deb" ]]
	then 
		echo "This is a debian file "
		dpkg -i $f 
		apt-get install -f

	
	else
		echo "There are other file format "

	fi
}
installfunction

