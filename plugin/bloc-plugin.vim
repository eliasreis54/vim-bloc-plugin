" bloc generator
" 1 - Mappings
nnoremap K :BlocPlugin
nnoremap K :CubitPlugin

function RenameAndDeleteFiles(...)
        let allFiles =  split(a:000[0])
        let type = a:000[1]
        let name = a:000[2]
        let path = a:000[3]
        let snakeCaseName = substitute(substitute(name, '\u', ' \l&', "g")[1:], ' ', '_', 'g')

        for i in allFiles
                let renameFileName = "sed -i'.bak' 's/<rename_file>/" . snakeCaseName . "/gi' " . path . "/" . type . "/" . i
                call system(renameFileName)

                let renameClassName = "sed -i'.bak' 's/<rename>/" . name . "/gi' " . path . "/" . type . "/" . i
                call system(renameClassName)

                let destinationName = snakeCaseName . "_" . i
                let renameSource = "mv " . path . "/" . type . "/" . i . " " . path .  "/" . type . "/" . destinationName
                call system(renameSource)

                let deleteFile = "rm " . path . "/" . type . "/" . i . ".bak"
                call system(deleteFile)
        endfor

        let remoGit = "rm -rf " . path . "/" . type . "/.git"
        call system(remoGit)

endfunction

function! BlocPlugin(...)
        let args = split(a:000[0])

        if len(args) < 2
                echo "You must pass the BlocName and destinationPath like ':Bloc BlocName lib/blocName'"
        else
                let blocName = args[0]
                let path = args[1]
                let command = "git clone https://github.com/eliasreis54/vim_bloc_plugin_source.git " . path . "/bloc/"

                call system(command)

                call RenameAndDeleteFiles("bloc.dart state.dart event.dart", 'bloc', blocName, path)
                echo "Bloc: All done"
        endif
endfunction

function! CubitPlugin(...)
        let args = split(a:000[0])

        if len(args) < 2
                echo "You must pass the CubitName and destinationPath like ':Cubit CubitName lib/blocName'"
        else
                let cubitName = args[0]
                let path = args[1]
                let command = "git clone https://github.com/eliasreis54/vim_bloc_plugin_cubit_source.git " . path . "/cubit/"

                call system(command)

                call RenameAndDeleteFiles("cubit.dart state.dart", "cubit", cubitName, path)
                echo "Cubit: All done"
        endif
endfunction

" Commands
command! -nargs=* Bloc call BlocPlugin(<q-args>)

command! -nargs=* Cubit call CubitPlugin(<q-args>)


