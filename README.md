# Defaults Backup Scripts
My custom scripts using the built-in OSX 'defaults' command line program for easy bulk exporting and importing of OSX system and application preferences.

## Examples

Export all domain property lists (including the global domain):
```bash
  ./export_defaults.sh some_dir  # Will export each domain to a file in folder some_dir
```
Import all domain property lists (including the global domain):
```bash
  ./import_defaults.sh some_dir  # Will import all exported domain files in some_dir
```
Import a single domain property list file:
```bash
  ./import_defaults.sh some_dir/some.domain.file  # Will import only some.domain.file from some_dir
```

**NOTE:** In some cases you may need to restart OSX or kill Finder, Dock, etc. depending on the changed defaults you imported.
