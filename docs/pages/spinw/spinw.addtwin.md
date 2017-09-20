---
{title: spinw.addtwin method, link: spinw.addtwin, summary: adds new twins to an spinw
    object, keywords: sample, sidebar: sw_sidebar, permalink: spinw_addtwin.html,
  folder: spinw, mathjax: 'true'}

---

### Syntax

`addtwin(obj,Name,Value)`

### Description



### Examples

...
cryst.addtwin('axis',[0 0 1],'phid',[60 120],'vol',[1 1])
This will add two extra crystallographic twins to the crystal, with the
original orientation there are will be three twins with equal volumes.

### Input Arguments

`obj`
: [spinw](spinw.html) object.

### Name-Value Pair Arguments

`axis`
: Defines axis of rotation to generate twins in the xyz
  coordinate system, dimensions are [1 3].

`phi`
: Defines the angle of rotation to generate twins in radian
  units, several twins can be defined parallel if phi is a
  vector. Dimensions are [1 nTwin].

`phid`
: Defines the angle of rotation to generate twins in degree
  units, several twins can be defined parallel if phi is a
  vector. Dimensions are [1 nTwin].

`rotC`
: Rotation matrices, that define crystallographic twins, can be
  given directly, dimensions are [3 3 nTwin].

`vol`
: Volume fractions of the twins, dimensions are [1 nTwin].
  Default value is ones(1,nTwin).

`overwrite`
: If true, the last twin will be overwritten, instead of adding a
  new one. Default is false.

### Output Arguments

The function adds extra entries in the 'twin' field of the obj spinw object.

### See Also

[spinw](spinw.html) \| [spinw.twinq](spinw_twinq.html)
