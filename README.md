---
author: Joachim H. Laubsch <laubsch@cup.hp.com>
---

# Zebu: A Tool for Specifying Reversible LALR(1) Parsers

Zebu is a kind of YACC, and was originally implemented in Scheme by
William M. Wells III.  It generates an LALR(1) parsing table. To parse
a string with a grammar, only this table and a driver need to be
loaded.

The present version of Zebu is an extension, rewritten in Common Lisp.
It contains the ability to define several grammars and parsers
simultaneously, a declarative framework for specifying the semantics,
capabilities to define and use meta-grammars (grammars to express a
grammar in), generation of unparsers (generators) using a 'reversible
grammar' notation, as well as efficiency related improvements.  

Zebu also contains a lexical analyzer which is based on the regular 
expression compiler written by Lawrence E. Freil <lef@nscf.org>.

Zebu compiles a grammar with 300 productions (including
dumping of the tables to disk) in approx 2 minutes and 30 seconds on a
HP 9000/370.

This implementation has been tested in Lucid CL, Allegro CL, and
MCL 2.0b.

For documentation look into the doc/ directory:

	Zebu_intro.tex 	contains an introduction to the Common Lisp
  version and the enhancements.  This is a LaTeX file.  The PostScript
  version is Zebu_intro.ps.

The test/ directory contains a few examples.  The file exercise.lisp runs
many of them.  Most example files also have a commented section at the end
that suggest some tests.

Other features, like grammar-names, string- or symbol-delimiters,
parameterization of lexical analysis, and modes of interpretation of
the grammar actions are also documented in zebu-loader.lisp.

If you need help or have suggestions, send email to:

        laubsch@cup.hp.com

	Joachim H. Laubsch
	Hewlett-Packard
	19477 Pruneridge Avenue (MS 47UI)
	Cupertino, CA 95014 

	Tel	408-447-5211
	Fax 	408-447-5229
