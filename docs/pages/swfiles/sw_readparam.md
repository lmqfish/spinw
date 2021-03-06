---
{title: sw_readparam, link: sw_readparam, summary: 'parse input arguments (option,
    value pairs)', keywords: sample, sidebar: sw_sidebar, permalink: sw_readparam,
  folder: swfiles, mathjax: 'true'}

---

### Syntax

`input = sw_readparam(format, raw)`

### Description

It reads in parameters from input structure. Lower and upper case
insensitive, the output structure has the names stored in format.fname.
Instead of a struct type input, also a list of parmeters can be given in
a parameter name, value pairs. Where the parameter name is a string.
 

### Input Arguments

`format`
:s struct type with the following fields:

`fname`
:  Field names, strings in cell, dimensions are [nParm 1].

`size`
:  field size, if negative means index, field sizes with same
   negative index have to be the same size.

`defval`
:  Optional, default value if missing.

`soft`
:  Optional, if exist and equal to 1, in case of bad input
   value, defval is used without error message.

{% include links.html %}
