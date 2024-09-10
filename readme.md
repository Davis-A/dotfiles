# My dots  

This is a repo with my dotfiles.  Everything is managed using [chezmoi](chezmoi.io)

The rest of this readme is mostly for myself because I tend to get my dotfiles where I like them then forget how to manage them 2 years later.

### Getting started

To get started, download chezmoi, then run `chezmoi init git@github.com:Davis-A/dotfiles.git` (or with https instead of git ssh)
The repo will be cloned to `~/.local/share/chezmoi`

After that, `chezmoi diff` will diff against the currently installed dotfiles.  And `chezmoi apply` will apply them.  
To diff or apply a single file just pass the filename eg `chezmoi diff ~.gitconfig` 

To add new files for chezmoi to look after `chezmoi add ~/foo`.  To use a template just add .tmpl to the end of the file in the repo, eg if i want to template `~/foo` i'd rename it `foo.tmpl` in the repo

### Chezmoi config  

To configure chezmoi itself `chezmoi.toml.tmpl` is the place to do it.  It is a template for configuring chezmoi itself and build on `chezmoi init`.  It gets installed in `~/.local/config/chezmoi/chezmoi.toml`

### Chezmoi data  

The `.chezmoidata/` directory, any data stored there (ie as toml, json, yaml) will be available in templates.  Annoyingly the top level key to access them is the top level key in the file NOT the name of the file.  ie if your file is foo.json and you have `{ "someKey": "somedata" }` the top level key to use is `{{ .someKey }}`, not `{{ foo.someKey }}`.  So make sure you key your data appropriately beyond the filename

### Secrets  

chezmoi supports integrations into a password manager like 1password or bitwarden ... i don't use it.

Password managers are great but I never use them for API keys, ssh keys etc I allocate them per device instead of a unified set.
So what i've done is taken advantage of the chezmoi data (read above).

Now to avoid an idiot mistake of checking in secrets, which isn't impossible to do even with a gitginore (i could totally see myself update a file then `git add secretfile.toml` out of habit editing a file in a git directory) i've instead put in a `.chezmoi/chezmoi-secrets.toml` symlink which links to:  
```
andrew@desktop ~/.l/s/chezmoi (master)> ls -lah .chezmoidata/
total 8.0K
drwxr-xr-x 2 andrew andrew 4.0K Sep 13 22:20 ./
drwxr-xr-x 8 andrew andrew 4.0K Sep 13 23:05 ../
lrwxrwxrwx 1 andrew andrew   41 Sep 13 22:20 chezmoi-secrets.toml -> ../../../../.secrets/chezmoi-secrets.toml
```
I've added a hook in `chezmoi.toml.tmpl` added a hook to run a setup script (`init/secrets.sh`) so the file and directory exist so we don't get missing key errors.  So if you have any secrets, just run `chezmoi diff`, that'll bootstrap the secrets file then add them under the secrets key eg:

```
[secrets]
[secrets.git.github]
host =  'github.com'
token = 'xxxx'
```

Why under the secrets key?  In `chezmoi.toml.tmpl` i've set it to ignore missing keys in templates, but it still balks if the top level key is missing.  So my secrets bootstrap creates the secrets file with the `[secrets]` key in there so there are no template errors.  If you create a template of {{ foo.git }} and then go to bootstrap another host and the foo key doesn't exist it'll get really sad.




I don't have unified secrets for things like API keys and such, i kee