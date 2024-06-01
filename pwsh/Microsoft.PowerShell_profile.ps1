# Powershell profile

function prof {
	nvim $PROFILE
}

function Prompt {
	$H = Get-Host
	$winsize = $H.UI.RawUI.WindowSize.Width
	#echo $winsize

	$hosttime = get-date -format yyyy.MM.dd::HH:mm:ss
	$place = $env:COMPUTERNAME + "]" + ($executionContext.SessionState.Path.CurrentLocation)

	$timesize = $hosttime.length
	$placesize = $place.length

	$padd = $winsize - $timesize - $placesize - 4
	#echo $padd
	if( $padd -gt 0 ){
		$pr = "[" + $place + "|" + ("-" * $padd) + "|" + $hosttime + "|"
	}
	if ( $Padd -le 0) {
		$pr = "|" + ("-" * ($winsize - $timesize - 3)) + "|" +  $hosttime + "|`n[" + $place
	}
	#echo $pr
	Write-Host $pr -ForegroundColor green
	echo ("|>" * ($nestedPromptLevel + 1))

}

#start zoxide !

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
