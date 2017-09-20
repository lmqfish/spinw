---
{title: spinw.addg method, link: spinw.addg, summary: assigns g-tensor to magnetic
    ions, keywords: sample, sidebar: sw_sidebar, permalink: spinw_addg.html, folder: spinw,
  mathjax: 'true'}

---

### Syntax

`addg(obj, matrixidx, {atomtypeidx}, {atomidx})`

### Description



### Examples

...
cryst.addmatrix('label','g1','value',diag([1.8 1.8 2.1]))
cryst.gencoupling
cryst.addg('g1')
This will add the 'g1' diagonal matrix to all magnetic atoms as
anisotropic g-tensor.

### Input Arguments

`matrixIdx`
: Either an integer, that selects the matrix
  obj.matrix.mat(:,:,matrixIdx), or a string identical to one
  of the previously defined matrix labels, stored in
  obj.matrix.label. Maximum value is nJ.

`atomTypeIdx`
: String or cell of strings that select magnetic atoms by
  their label. Also can be a vector that contains integers,
  the index of the magnetic atoms in obj.unit_cell, with all
  symmetry equivalent atoms. Maximum value is nAtom, if
  undefined g-tensor is assigned to all magnetic atoms.
  Optional.
  A vector that contains indices selecting some of the
  symmetry equivalent atoms. Maximum value is the number of
  symmetry equivalent atoms generated. If crystal symmetry is
  not 0, atomIdx is not allowed, since the g-tensor for
  equivalent atoms will be calculated using the symmetry
  operators of the space group. Optional.

### Output Arguments

The function adds extra entries in the 'single_ion.g' field of the obj sw
object.

### See Also

[spinw](spinw.html) \| [spinw.addcoupling](spinw_addcoupling.html) \| [spinw.addaniso](spinw_addaniso.html) \| [spinw.addmatrix](spinw_addmatrix.html)
