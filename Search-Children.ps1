Function Search-Children($searchTerm) 
{
    $path = ""
    $colorIter = 0
    [string[]]$colors = "DarkCyan","DarkRed"

    Get-ChildItem $PWD -Recurse |
    Select-String -Pattern $searchTerm -AllMatches -CaseSensitive |
    ForEach-Object -Process { 

        if ($_.Path -ne $path)
            { $colorIter = ($colorIter + 1) % $colors.Length }

        Write-Host $_.RelativePath($PWD) -NoNewLine -ForegroundColor $colors[$colorIter]
        Write-Host (':' + $_.LineNumber) -NoNewLine -ForegroundColor  

        $matchStartIndex = $_.Line.IndexOf($_.Matches[0])
        $matchEndIndex = $matchStartIndex + $_.Matches[0].Length

        Write-Host $_.Line.Substring(0, $matchStartIndex) -NoNewLine
        Write-Host $_.Line.Substring($matchStartIndex, $matchEndIndex - $matchStartIndex) -NoNewLine -ForegroundColor Green
        Write-Host $_.Line.Substring($matchEndIndex)

        $path = $_.Path
    }
}
