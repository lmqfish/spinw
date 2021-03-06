---
{title: sw_cartesian, link: sw_cartesian, summary: creates a right handed Cartesian
    coordinate system, keywords: sample, sidebar: sw_sidebar, permalink: sw_cartesian,
  folder: swfiles, mathjax: 'true'}

---

### Syntax

`[vy, vz, vx] = sw_cartesian(n)`

### Description

V = SW_CARTESIAN(n)
 
It creates an (x,y,z) right handed Cartesian coordinate system with vx,
vy and vz defines the basis vectors. If only a single output is required,
V will contain the basis vectors in a matrix: V = [vx vy vz].
 

### Input Arguments

`n`
: Either a 3 element row/column vector or a 3x3 matrix with
  columns defining 3 vectors.

### Output Arguments

vy,vz,vx  Vectors defining the right handed coordinate system. They are
          either column of row vectors depending on the shape of the
          input n.

{% include links.html %}
