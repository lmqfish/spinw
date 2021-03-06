---
{title: sw_rotmatd, link: sw_rotmatd, summary: rotates vectors around arbitrary axis
    in 3D, keywords: sample, sidebar: sw_sidebar, permalink: sw_rotmatd, folder: swfiles,
  mathjax: 'true'}

---

### Syntax

`rotm = sw_rotmat(rotaxis, rotangle)`

### Description

It rotates vectors in V around rotAxis by rotAngle DEGREE (positive angle
is the right-hand direction).
 

### Input Arguments

`rotAxis`
: Axis of rotation, dimensions are [1 3].

`rotAngle`
: Angle of rotation in ° (can be vector with dimensions of
  [1 nAng]).

### Output Arguments

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

[spinw.genmagstr](spinw_genmagstr) \| [sw_rot](sw_rot) \| [sw_mirror](sw_mirror)

{% include links.html %}
