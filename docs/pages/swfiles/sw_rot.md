---
{title: sw_rot, link: sw_rot, summary: rotates vectors around arbitrary axis in 3D,
  keywords: sample, sidebar: sw_sidebar, permalink: sw_rot, folder: swfiles, mathjax: 'true'}

---

### Syntax

`[v, rotm] = sw_rot(rotaxis, rotangle, {v})`

### Description

It rotates vectors in V around rotAxis by rotAngle radian (positive angle
is the right-hand direction).
 

### Input Arguments

`rotAxis`
: Axis of rotation, dimensions are [1 3].

`rotAngle`
: Angle of rotation in radian (can be vector with dimensions of
  [1 nAng]).

`V`
: Matrix of 3D vectors, dimensions are [3 N], optional.

### Output Arguments

V         Rotated vectors, dimensions are [3 N nAng].
rotM      Rotation matrix, dimensions are [3 3]. If rotAngle is a vector,
          rotM contains rotation matrices for every angle, it's
          dimensions are [3 3 nAng].
The rotation matrix defines rotations in a right-handed coordinate
system, the positive direction is counter-clockwise, when looking from
where the rotation axis points. To rotate any column vector use the
following:
  vp = rotM * v;
To rotate tensors (3x3 matrices) use the following command:
  Ap = rotM * A * rotM';

### See Also

[spinw.genmagstr](spinw_genmagstr) \| [sw_rotmat](sw_rotmat) \| [sw_mirror](sw_mirror)

{% include links.html %}
