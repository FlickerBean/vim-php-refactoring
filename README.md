PHP Refactoring Support for VIM
===============================

PHP Refactoring support for VIM using [php-refactorings-browser https://github.com/QafooLabs/php-refactoring-browser]
Modified to support refactoring within vims buffer instead of the previous method
of patching the file directly and reloading vim. 
This allows the following advantages:
* Refactoring modified buffers without being forced to save them first.
* Undoing/Redoing refactors.
* Viewing the refactored changes before saving them to disk.
* An all around more seamless feel.

This version requires a custom refactor.phar, that allows support for stdin which 
can be gotten from my fork of https://github.com/FlickerBean/php-refactoring-browser

Installation
------------

### Using Vundle
Add `Bundle 'vim-php/vim-php-refactoring'` to your `.vimrc` file and then:
* either run `:BundleInstall` within vim
* or run `vim +BundleInstall +qall` from your shell

### Configuring

You also need to Download `refactor.phar` from
https://github.com/FlickerBean/php-refactoring-browser and add

`let g:php_refactor_command='php /path/to/refactor.phar'`

to your `.vimrc` file.

Usage
-----

When inside a PHP file the following mappings work

### EXTRACT METHOD
Go into visual mode and select the code you want to extract to a new
method the press `<Leader>rem`

You will be prompted for the name of the new method.

### RENAME LOCAL VARIABLE
In normal mode move the cursor so it's inside the name of the variable
which you want to rename. Press `<Leader>rlv`

You will be prompted for the new name of the variable.

### LOCAL VARIABLE TO INSTANCE VARIABLE
In normal mode move the cursor so it's inside the name of the variable
which you want to rename. Press `<Leader>rli`

### OPTIMIZE USE
Simple press `<Leader>rou` to run the optimize use refactoring.
