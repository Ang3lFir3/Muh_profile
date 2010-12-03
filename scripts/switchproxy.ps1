$IHazACorpIP = $false

foreach ($address in [System.Net.Dns]::Resolve([System.Environment]::MachineName).AddressList)
{
    if ($address.IPAddressToString.StartsWith("10.0.16"))
        { $IHazACorpIP = $true }
}

if ($IHazACorpIP) { echo "I haz a corp ip address!" } else { echo "Couldn't find a corp ip address!" }

Push-Location 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'

$proxyInfo = Get-ItemProperty . -Name ProxyEnable

if ($IHazACorpIP -and $proxyInfo.ProxyEnable)
{ 
	SetHttpProxyEnv("proxy1.russell.com:8080")
	echo "Proxy already enabled, good luck!" 
}

if ($IHazACorpIP -and !$proxyInfo.ProxyEnable )
{
    echo "Enabling proxy through corp draconian firewall"
	SetHttpProxyEnv("proxy1.russell.com:8080")
    Set-ItemProperty . -Name ProxyEnable -Value $true
}

if (!$IHazACorpIP)
{
    echo "Disabling proxy, yay!"
	SetHttpProxyEnv("")
    Set-ItemProperty . -Name ProxyEnable -Value $false
}

Pop-Location