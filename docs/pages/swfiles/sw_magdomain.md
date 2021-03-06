---
{title: sw_magdomain, link: sw_magdomain, summary: calculates the spin-spin correlation
    function for magnetic domains, keywords: sample, sidebar: sw_sidebar, permalink: sw_magdomain,
  folder: swfiles, mathjax: 'true'}

---

### Syntax

`spectra = sw_magdomain(spectra,Name,Value)`

### Description

The function can account for magnetic domains that are related by any
point group operation. Several domains with different volume ratios can
be defined. The spin-spin correlation function will be rotated and summed
according to the domains. The rotations of the magnetic domains are
defined in the xyz coordinate system, same as the coordinate system for
the spin-spin correlation function.
 

### Examples

...
spec = cryst.spinwave({[0 0 0] [1 0 0]});
spec = sw_magdomain(spec,'axis',[0 0 1],'angled',[0 90 180 270]);
The above example calculates the spectrum for magnetic domains that are
related by a 90 ° rotation around the z-axis (perpendicular to the
ab plane). All domains have equal volume.

### Input Arguments

`spectra`
: Calculated spin wave spectrum.

### Name-Value Pair Arguments

`'axis'`
: Defines axis of rotation to generate twins in the xyz
  coordinate system, dimensions are [1 3].

`'angle'`
: Defines the angle of rotation to generate twins in radian
  units, several twins can be defined parallel if angle is a
  vector. Dimensions are [1 nTwin].

`'angled'`
: Defines the angle of rotation to generate twins in °
  units, several twins can be defined parallel if angle is a
  vector. Dimensions are [1 nTwin].

`'rotC'`
: Rotation matrices, that define crystallographic twins, can be
  given directly, dimensions are [3 3 nTwin].

`'vol'`
: Volume fractions of the twins, dimensions are [1 nTwin].
  Default value is ones(1,nTwin).

### Output Arguments

'spectra' will contain the following additional/changed fields:
Sab       The multi domain spectrum will be stored here.
Sabraw    The original single domain spectrum is kept here, so that a
          consecutive run of sw_magdomain will use the original single
          domain spectrum, without the need of recalculating the full
          spectrum.
domVol    Volume of each domains in a vector, with dimensions of
          [1 nDom], where nDom is the number of domains.
domRotC   Rotation matrices for each domain, with dimensions of
          [3 3 nDom].

### See Also

[spinw.spinwave](spinw_spinwave) \| [spinw.addtwin](spinw_addtwin) \| [spinw.twinq](spinw_twinq)

{% include links.html %}
