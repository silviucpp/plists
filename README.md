Erlang plists
=============

This is a fork of the Google Code SVN repository for plists.
The original code is available at: <http://code.google.com/p/plists/>.


Summary
-------

`plists` is a drop-in replacement for the Erlang module `lists`, making most
list operations parallel. It can operate on each element in parallel, for IO-
bound operations, on sublists in parallel, for taking advantage of multi-core
machines with CPU-bound operations, and across erlang nodes, for parallizing
inside a cluster. It handles errors and node failures. It can be configured,
tuned, and tweaked to get optimal performance while minimizing overhead.

Almost all the functions are identical to equivalent functions in `lists`,
returning exactly the same result, and having both a form with an identical
syntax that operates on each element in parallel and a form which takes an
optional "malt", a specification for how to parallize the operation.

`fold` is the one exception, parallel `fold` is different from linear `fold`.
This module also includes a simple `mapreduce` implementation, and the function
`runmany`. All the other functions are implemented with `runmany`, which is as a
generalization of parallel list operations.

Documentation is available at <http://freeyourmind.googlepages.com/plists.html>,
and a blog post with some examples at
<http://plists.wordpress.com/2007/09/20/introducing-plists-an-erlang-module-for-doing-list-operations-in-parallel/>.


Building and Installing
-----------------------

To build, simply use the `Makefile` provided in the project:

    $ make compile

This will create a `beam` file in the `./ebin` directory.

If you'd like to build the docs:

    $ make docs

The updated docs will be in the `./doc` directory.

To install `plists` in your Erlang system, simply point the `make` target at
your preferred library. For instance, if your Erlang is running out of
`/opt/erlang/r15b03`, do the following:

    $ ERL_LIBS=/opt/erlang/r15b03/lib make install