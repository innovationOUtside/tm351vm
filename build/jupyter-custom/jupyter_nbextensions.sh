#!/usr/bin/env bash

if [ ! -f /opt/jupyter_nbextensions.done ]; then


    #Go for the easy option and src all the jupyter_contrib_nbextensions 
    $PIPNC jupyter_contrib_nbextensions
    
    $PIPNC RISE
    $PIPNC jupyter-wysiwyg
    $PIPNC git+https://github.com/uclixnjupyternbaccessibility/accessibility_toolbar.git
    
    $PIPNC nbresuse

    #Install nbgrader
    $PIPNC install nbgrader
  

    #The service runs under oustudent user but we're root here...
    # So if we install as --user, thats wrong... 
    #su $NB_USER <<-EOF
        jupyter contrib nbextension install --sys-prefix

        #Enable certain extensions from the start
        jupyter nbextension enable freeze/main --sys-prefix
        jupyter nbextension enable highlighter/highlighter --sys-prefix
        jupyter nbextension enable spellchecker/main --sys-prefix
        jupyter nbextension enable collapsible_headings/main --sys-prefix
        jupyter nbextension enable codefolding/main --sys-prefix
        jupyter nbextension enable rubberband/main --sys-prefix
        jupyter nbextension enable exercise2/main --sys-prefix
        jupyter nbextension enable python-markdown/main --sys-prefix
        jupyter nbextension enable export_embedded/main --sys-prefix

        jupyter nbextension enable skip-traceback/main --sys-prefix
        jupyter nbextension enable hide_input/main --sys-prefix
        jupyter nbextension enable init_cell/main --sys-prefix

        #Accessibility
        jupyter nbextension install accessibility_toolbar --sys-prefix
        jupyter nbextension enable accessibility_toolbar/main
        
        #Slideshow
        jupyter nbextension install rise  --py --sys-prefix
        jupyter nbextension enable rise  --py --sys-prefix
        
        #WYSIWYG editor
        jupyter nbextension install jupyter_wysiwyg  --py --sys-prefix
        jupyter nbextension enable jupyter_wysiwyg --py --sys-prefix
        

        # Resource monitoring
        jupyter serverextension enable --py nbresuse --sys-prefix
        jupyter nbextension install --py nbresuse --sys-prefix
        jupyter nbextension enable --py nbresuse --sys-prefix

        #nbgrader - do not enable by default
        #jupyter nbextension install --sys-prefix --py nbgrader --overwrite
        #jupyter nbextension enable --sys-prefix --py nbgrader
        #jupyter serverextension enable --sys-prefix --py nbgrader
    
#EOF

    touch /opt/jupyter_nbextensions.done
fi

#If not the Docker build, set up the services
if [[ -z "${DOCKERBUILD}" ]]; then
	#restart the service
	systemctl restart jupyter.service
fi