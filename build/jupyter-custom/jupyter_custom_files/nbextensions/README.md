# Notes on creating and packaging extensions

### EXTENSIONS

Create zip file for pip install

- `cd DIR; zip -r DIR.zip ./*`

Install from zipfile:

`!pip3 install --upgrade --force-reinstall /vagrant/PATH/DIR.zip`

Enable extension:

`!jupyter bundlerextension enable --py EXT.EXTENSION  --sys-prefix`

Restart server:

`!systemctl restart jupyter.service`


### Trying customisation:

//via http://stackoverflow.com/a/29484938/454773

`pandoc -D docx > my_template.docx`

Edit the styles in `my_template.docx`.

*I added a logo image in header but didn't seem to work in the following...*

`pandoc -s myfile.html --template=my_template -o test64.docx`

