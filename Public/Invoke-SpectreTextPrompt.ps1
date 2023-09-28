using namespace System.Management.Automation
using namespace System.Management.Automation.Language
using namespace System.Collections
using namespace System.Collections.Generic

class ColorNames : IArgumentCompleter {

    static [Reflection.PropertyInfo[]] $Set

    static ColorNames() {
        [ColorNames]::Set = ('Spectre.Console.Color' -as [type]).GetProperties()
    }

    [IEnumerable[CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $ParameterName,
        [string] $WordToComplete,
        [CommandAst] $CommandAst,
        [IDictionary] $FakeBoundParameters
    ) {
        [CompletionResult[]] $result = foreach($color in [ColorNames]::Set) {
            if($color.Name.StartsWith($wordToComplete, [StringComparison]::InvariantCultureIgnoreCase)) {
                [CompletionResult]::new($color.Name)
            }
        }
        return $result
    }
}

class SpectreColorTransformer : Management.Automation.ArgumentTransformationAttribute {
    [object] Transform([Management.Automation.EngineIntrinsics]$engineIntrinsics, [object]$inputData) {

        $colorType = 'Spectre.Console.Color' -as [type]

        if ($inputData -is [Array] -and $_.Length -eq 3) {
            return $colorType::new($inputData[0], $inputData[1], $inputData[2])
        }

        $outputData = switch ($inputData) {

            { $_ -is $colorType } { $_ }

            { $_ -is [string] } {

                if($_.StartsWith('#')){

                    if ($_ -match '^#([a-z0-9]{1,8})$') {

                        $intValue = [int]"0x$($_.Substring(1))"

                        $colorType::new(
                            [byte](($intValue -band 0xFF0000) -shr 16),
                            [byte](($intValue -band 0xFF00) -shr 8),
                            [byte]($intValue -band 0xFF)
                        )

                    } else {
                        throw [Management.Automation.ArgumentTransformationMetadataException]::new(
                            "Malformed hex value passed. '$_' is not a valid hex color code."
                        )
                    }

                } else {
                    $colorType::$_
                }
            }

            { $_ -is [int] } { $colorType::FromInt32($_) }

            default {
                throw [Management.Automation.ArgumentTransformationMetadataException]::new(
                    "Could not convert input '$_' to a valid Color object."
                )
            }
        }

        return $outputData
    }
}

function Invoke-SpectreTextPrompt {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        $Prompt,

        [Parameter(Mandatory=$false)]
        [SpectreColorTransformer()]
        [ArgumentCompleter([ColorNames])]
        [Spectre.Console.Color]
        $PromptFGColor = '#FFFFFF',

        [Parameter(Mandatory=$false)]
        [SpectreColorTransformer()]
        [ArgumentCompleter([ColorNames])]
        [Spectre.Console.Color]
        $PromptBGColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet('None','Bold','Dim', 'Italic', 'Underline',
        'Invert', 'Conceal', 'SlowBlink', 'RapidBlink',
        'Strikethrough', IgnoreCase = $true)]
        [String]
        $PromptDeco = 'None',

        [Parameter(Mandatory=$false)]
        [String]
        $ConfirmPrompt,

        [Parameter(Mandatory=$false)]
        [Switch]
        $ClearScreenBeforeDisplay

    )

    begin {
        if($ClearScreenBeforeDisplay){
            Clear-Host
        }
    }

    process {

        $promptStyle = [Spectre.Console.Style]::new($PromptFGColor, $PromptBGColor, $PromptDeco, $null)
        $prm = [Spectre.Console.TextPrompt[string]]::new($Prompt)
        $prm.PromptStyle = $promptStyle

        $promptResult = [Spectre.Console.AnsiConsole]::Prompt($prm)

        if(![String]::IsNullOrWhiteSpace($ConfirmPrompt)){
            [Spectre.Console.AnsiConsole]::MarkupLine($ConfirmPrompt)
        }

        return $promptResult

    }

}