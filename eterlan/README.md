# ETERLAN SEPTEBMER

### Code

*   [eterlan.bf](eterlan.bf), written in [Befunge-93](https://esolangs.org/wiki/Befunge).

### Novel

*   [ETERLAN SEPTEBMER.md](../generated/ETERLAN%20SEPTEBMER.md), exactly 50,000 words

### Notes

In Usenet slang, [Eternal September][] refers to September 1993, the month that AOL
started heavily promoting Usenet access to the general public.  The Internet would
never be the same again.

September 1993 is also when the Befunge programming language was invented.

(These two events are generally considered to be coincidental.)

This novel generator was written in 2018 to mark the 25th anniversary of the
invention of Befunge.

The novel was generated with [bef][], the Befunge-93 reference interpreter
(using the `-q` option to suppress extraneous output).

Being a two-dimensional language, program flow in Befunge can proceed in
any of the four cardinal directions: up, down, left, or right.
Befitting of this, the Befunge programming language does not have a
facility for generating random numbers.  Instead, it generates random
directions -- the `?` instruction randomly selects up, down, left, or right.

This generator exploits that by presenting a grid of literal characters, with
`?` instructions at the intersections.  Characters are accumulated as the
program wanders this grid, back-and-forth, until it gets to the edge, at
which point a word is output, and the process repeats until we get 50,000 words.

Due to this method, the random strings of characters produced by this
generator have a certain quality that does not appear when using other
more common methods of random generation.

[bef]: http://catseye.tc/distribution/Befunge-93_distribution
[Eternal September]: https://en.wikipedia.org/wiki/Eternal_September
