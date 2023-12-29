@{
    RootModule = 'VSYSGUIOps.psm1'
    ModuleVersion = '1.0.0'
    GUID = '9a935256-9503-5b28-a5dd-14dac0b376dc'
    Author = 'futur'
    CompanyName = 'Futuremotion'
    Copyright = '(c) Futuremotion. All rights reserved.'

    CompatiblePSEditions = @('Core')

    Description = 'Provides functions related to working with files and paths.'
    PowerShellVersion = '7.0'

    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    ScriptsToProcess = @()
    TypesToProcess = @()
    FormatsToProcess = @()
    FileList = @()

    # Leave commented out to import into any host.
    # PowerShellHostName = ''

    RequiredModules = @('BurntToast')
    RequiredAssemblies = 'System.Drawing', 
                         'System.Windows.Forms',
                         #'Lib\Spectre.Console.dll',
                         'Lib\Ookii.Dialogs.WinForms.dll',
                         'PresentationCore',
                         'PresentationFramework',
                         'Microsoft.VisualBasic'
                        
    FunctionsToExport =  'Invoke-OpenFileDialog',
                         'Invoke-VBMessageBox',
                         'Convert-Color',
                         'Invoke-GUIMessageBox',
                         'Invoke-OokiiInputDialog',
                         'Invoke-OokiiPasswordDialog',
                         'Invoke-OokiiTaskDialog',
                         'Invoke-SaveFileDialog',
                         'Invoke-OpenFolderDialog',
                         'Invoke-SpectreConsoleSelection',
                         'Invoke-SpectreConsoleMultiselection',
                         'Invoke-SpectreTextPrompt',
                         'Invoke-SpectreTextPromptConfirm',
                         'Invoke-VBInputMessageBox',
                         'Invoke-SpectrePrintMarkup'

    PrivateData = @{
        PSData = @{

            Tags =  'GUI', 
                    'UI', 
                    'User Interface', 
                    'Dialog', 
                    'Message Box', 
                    'MessageBox', 
                    'Color', 
                    'Input', 
                    'Console Prompts'

            LicenseUri = 'https://github.com/fmotion1/VSYSGUIOps/blob/main/LICENSE'
            ProjectUri = 'https://github.com/fmotion1/VSYSGUIOps'
            IconUri = 'https://raw.githubusercontent.com/fmotion1/VSYSGUIOps/main/Img/GUIOpsIconUri.png'
            ReleaseNotes = '1.0.0: (09-29-2023) - Initial Release'
        }
    }
}

