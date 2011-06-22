Import-Module posh-git
Import-Module Chewie

$env:Path += ";c:\scripts;c:\tools;c:\tools\perforce"
Set-Location D:\projects


function prompt {
	Write-Host(Get-Prompt($pwd)) -nonewline
	$Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus
	
    ">"
}

function Get-Prompt([string] $path)
{
	if ($path.Length -lt 35) { return $path}
	
    $loc = "";
    $tokens = $path.Split('\');
    
    for ($i = 0; $i -lt $tokens.Count -1; $i++)
    {
        $loc += $tokens[$i][0] + '\';
    }
    $loc = $loc.ToUpper()
    $loc += $tokens[$tokens.count -1]
       
    return $loc;
}

#aliases
New-Alias -name 'np' -value 'C:\Program Files (x86)\Notepad++\notepad++.exe'

#posh git stuffs
if(-not (Test-Path Function:\DefaultTabExpansion)) {
    Rename-Item Function:\TabExpansion DefaultTabExpansion
}
# Set up tab expansion and include git expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]
    
    switch -regex ($lastBlock) {
        # Execute git tab completion for all git-related commands
        'git (.*)' { GitTabExpansion $lastBlock }
        # Fall back on existing tab expansion
        default { DefaultTabExpansion $line $lastWord }
    }
}

function touch([string] $path) 
{	$test = test-path($path)
	if(!$test) {new-item -path $path -type file}
	
	np $path
}

function SetHttpProxyEnv($proxy)
{
	$env:HTTP_PROXY = $proxy
	$env:HTTPS_Proxy = $proxy
}
