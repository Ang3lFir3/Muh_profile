param($name)

$the_path = "$pwd\$name"

function create-project([string] $name)
{
	if(!$(test-path $the_path)){
		new-item $the_path -type directory
	}
	
	$the_dirs = "src","lib","build","tools","docs","scripts","packages"
	foreach($dir in $the_dirs){ mkdir "$the_path\$dir" }
}

create-project($name)


