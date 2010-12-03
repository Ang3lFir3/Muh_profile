$env:Path += ";c:\scripts;c:\tools"
Set-Location D:\projects

function prompt {

$path = (Get-Location).Path

    if ($path.Length -gt 45)
    {
        $path = Get-Prompt($path);
    }    
    "$path>"
}

function Get-Prompt([string] $path)
{
    $loc = "";
    $tokens = $path.Split('\');
    
    for ($i = 0; $i -lt $tokens.Count -1; $i++)
    {
        $loc += $tokens[$i][0] + '\';
    }
    
    $loc += $tokens[$tokens.count -1]
       
    return $loc.ToUpper();
}

function touch([string] $path) 
{	$test = test-path($path)
	if(!$test) {new-item -path $path -type file}
}

function SetHttpProxyEnv($proxy)
{
	$env:HTTP_PROXY = $proxy
	$env:HTTPS_Proxy = $proxy
}
New-Alias -name 'np' -value 'C:\Program Files (x86)\Notepad++\notepad++.exe'
