" bloc generator
" 1 - Mappings
nnoremap K :BlocPlugin

" 2 - Functions
function! BlocPlugin(...)
        let args = split(a:000[0])

        if len(args) < 2
                echo "You must pass the BlocName and destinationPath like ':Bloc BlocName lib/blocName'"
        else
                let blocName = args[0]
                let path = args[1]
                let command = "git clone git@github.com:eliasreis54/vim_bloc_plugin_source.git " . path . "/bloc/"

                call system(command)

                for i in ["bloc.dart", "state.dart", "event.dart"]
                        let renameFileName = "sed -i 's/<rename_file>/" . tolower(blocName) . "/gi' " . path . "/bloc/" . i
                        call system(renameFileName)

                        let renameClassName = "sed -i 's/<rename>/" . blocName . "/gi' " . path . "/bloc/" . i
                        call system(renameClassName)

                        let destinationName = tolower(blocName) . "_" . i
                        let renameSource = "mv " . path . "/bloc/" . i . " " . path .  "/bloc/" . destinationName
                        call system(renameSource)
                endfor

                echo "All done"
        endif
endfunction

" Commands
command! -nargs=* Bloc call BlocPlugin(<q-args>)
