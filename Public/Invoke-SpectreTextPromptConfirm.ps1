function Invoke-SpectreTextPromptConfirm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $Prompt,

        [Parameter(Mandatory=$false)]
        [String]
        $ConfirmSuccess,

        [Parameter(Mandatory=$false)]
        [String]
        $ConfirmFail
    )

    process {

        $prm = [Spectre.Console.AnsiConsole]::Confirm($Prompt)
        if($prm -eq $false){
            if(![String]::IsNullOrWhiteSpace($ConfirmFail)){
                [Spectre.Console.AnsiConsole]::MarkupLine($ConfirmFail)
            }
        }else{
            if(![String]::IsNullOrWhiteSpace($ConfirmSuccess)){
                [Spectre.Console.AnsiConsole]::MarkupLine($ConfirmSuccess)
            }
        }

        return $prm
    }
}