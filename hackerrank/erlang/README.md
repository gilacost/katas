# Erlang code katas 🤟

I love the BEAM ecosystem and after 5 years working with elixir I thought the next
natural step was to learn some erlang for the great good 😉.

## Running the tests 🤓

There is a Makefile that allows to easily run the tests. It removes all
compiled `.beam` files, then runs `erl --make` and then `rebar3 eunit`.

Run:

```bash
make test
```

Running a single test:

```bash
erl -make && erl -eval 'eunit:test(MODULE).'
```

## Emakefile 🤹‍♂️

In order to ensure that warnings are treated as errors an `Emakefile` has been
added to the repo. Find more docs about Emakefile
[here](https://erlang.org/doc/man/make.html).


## Debugging in the Eshell 🚧

If you want to play with any of the modules implemented for the challenges get
into the Eshell with `erl`, compile the module and execute the main function.

```bash
Eshell V11.0.2  (abort with ^G)
1> pwd().
/Users/pepo/Repos/hackerl_rank
ok
2> c(solution_1).
{ok,solution}
4> solution_1:main().
...
```

## Auto format ( vim users ) 👨🏻‍💻

I am a vim user and when I started this challenges the code was not being
formatted. That was making me sad, so I submitted a
[PR](https://github.com/dense-analysis/ale/pull/3389) to
[ale](https://github.com/dense-analysis/ale), to allowusing WhatsApp
[elrfmt](https://github.com/WhatsApp/erlfmt). To have the code formated `cd`
into the project and `rebar3 get-deps`. Then you should be able to run `rebar3
fmt`.

Plug config:

```bash
...
Plug 'https://github.com/gilacost/ale.git', { 'branch': 'allow-erlfmt-as-fixer' }
...
let g:ale_fixers = {
...
\   'erlang': ['erl_fmt'],
...
}
...

```
