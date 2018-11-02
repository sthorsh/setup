# bind

> Bind key sequence to readline function or set a readline variable.

- List keyseq-to-readline-function bindings:

`bind -p`

- List readline variables:

`bind -v`

- Bind key sequence to readline function:

`bind {{'"keyseq": readlnfn'}}`

- Bind key sequence to shell command:

`bind -x {{'"keyseq": shellcmd'}}`
