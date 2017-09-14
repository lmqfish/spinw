function spectra = powspec(obj, hklA, varargin)
% calculates powder averaged spin wave spectra
%
% spectra = POWSPEC(obj, hklA, 'Option1', Value1, ...)
%
% The function calculates powder averaged spectrum by doing a 3D average in
% momentum space. This method is not efficient for low dimensional (2D, 1D)
% structures. To speed up the calculation with mex files use the
% swpref.setpref('usemex',true) option. The function can do powder average
% on arbitrary spectral function, but it is currently tested with two
% functions:
%       spinw.spinwave  Powder average spin wave spectrum.
%       spinw.scga      Powder averaged diffuse scattering spectrum.
% The type of spectral function is determined by the specfun option.
%
% Input:
%
% obj       spinw class object.
% hklA      Vector containing the Q values in inverse Angstrom where powder
%           spectra will be calculated, dimensions are [1 nQ].
%
% Options:
%
% specfun   Function handle of the spectrum calculation function. Default
%           is @spinwave.
% nRand     Number of random orientations per Q value, default is 100.
% Evect     Vector, defines the center/edge of the energy bins of the
%           calculated output, dimensions are is [1 nE]. The energy units
%           are defined by the unit.kB property of the spinw object. Default
%           value is an edge bin: linspace(0,1.1,101).
% binType   String, determines the type of bin give, possible options:
%               'cbin'    Center bin, the center of each energy bin is given.
%               'ebin'    Edge bin, the edges of each bin is given.
%           Default is 'ebin'.
% T         Temperature to calculate the Bose factor in units
%           depending on the Boltzmann constant. Default is taken from
%           obj.single_ion.T value.
% title     Gives a title string to the simulation that is saved in the
%           output.
% extrap    If true, arbitrary additional parameters are passed over to
%           the spectrum calculation function.
% fibo      If true, instead of random sampling of the unit sphere the
%           Fibonacci numerical integration is implemented as described in:
%           J. Phys. A: Math. Gen. 37 (2004) 11591
%           The number of points on the sphere is given by the largest
%           Fibonacci number below nRand. Default is false.
% imagChk   Checks that the imaginary part of the spin wave dispersion is
%           smaller than the energy bin size. Default is true.
% component See the help of sw_egrid() function for description.
%
% The function accepts all options of spinw.spinwave() with the most
% important options are:
%
% formfact      If true, the magnetic form factor is included in the
%               spin-spin correlation function calculation. Default value
%               is false.
% formfactfun   Function that calculates the magnetic form factor for given
%               Q value. Default value is @sw_mff(), that uses a tabulated
%               coefficients for the form factor calculation. For
%               anisotropic form factors a user defined function can be
%               written that has the following header:
%                   F = @formfactfun(atomLabel,Q)
%               where the parameters are:
%                   F   row vector containing the form factor for every
%                       input Q value
%                   atomLabel string, label of the selected magnetic atom
%                   Q   matrix with dimensions of [3 nQ], where each column
%                       contains a Q vector in Angstrom^-1 units.
% gtensor       If true, the g-tensor will be included in the spin-spin
%               correlation function. Including anisotropic g-tensor or
%               different g-tensor for different ions is only possible
%               here.
% hermit        Method for matrix diagonalization:
%                   true      J.H.P. Colpa, Physica 93A (1978) 327,
%                   false     R.M. White, PR 139 (1965) A450.
%               Colpa: the grand dynamical matrix is converted into another
%                      Hermitian matrix, that will give the real
%                      eigenvalues.
%               White: the non-Hermitian g*H matrix will be diagonalised,
%                      that is not the elegant method.
%               Advise:
%               Always use Colpa's method, except when small imaginary
%               eigenvalues are expected. In this case only White's method
%               work. The solution in this case is wrong, however by
%               examining the eigenvalues it can give a hint where the
%               problem is.
%               Default is true.
%
% The function accepts some options of spinw.scga() with the most important
% options are:
%
% nInt      Number of Q points where the Brillouin zone is sampled for the
%           integration.
%
% Output:
%
% 'spectra' is a struct type variable with the following fields:
% swConv    The spectra convoluted with the dispersion. The center
%           of the energy bins are stored in spectra.Evect. Dimensions are
%           [nE nQ].
% hklA      Same Q values as the input hklA [1 nQ]. Evect
%           Contains the input energy transfer values, dimensions are
%           [1 nE].
% param     Contains all the input parameters.
% obj       The copy of the input obj object.
% Evect     Energy grid converted to edge bins.
%
% Example:
%
% tri = sw_model('triAF',1);
% E = linspace(0,4,100);
% Q = linspace(0,4,300);
% triSpec = tri.powspec(Q,'Evect',E,'nRand',1e3);
% sw_plotspec(triSpec);
%
% The example calculates the powder spectrum of the triangular lattice
% antiferromagnet (S=1, J=1) between Q = 0 and 3 A^-1 (the lattice
% parameter is 3 Angstrom).
%
% See also SPINW, SPINW.SPINWAVE, SPINW.OPTMAGSTR, SW_EGRID.
%

% help when executed without argument
if nargin==1
    help spinw.powspec
    return
end

fid = swpref.getpref('fid',true);

hklA = hklA(:)';
T0 = obj.single_ion.T;

title0 = 'Powder LSWT spectrum';
tid0   = swpref.getpref('tid',[]);

inpForm.fname  = {'nRand' 'Evect'    'T'   'formfact' 'formfactfun' 'tid' 'nInt'};
inpForm.defval = {100     zeros(1,0) T0    false      @sw_mff       tid0  1e3   };
inpForm.size   = {[1 1]   [1 -1]     [1 1] [1 -2]     [1 1]         [1 1] [1 1] };

inpForm.fname  = [inpForm.fname  {'hermit' 'gtensor' 'title' 'specfun' 'imagChk'}];
inpForm.defval = [inpForm.defval {true     false     title0  @spinwave  true    }];
inpForm.size   = [inpForm.size   {[1 1]    [1 1]     [1 -3]  [1 1]      [1 1]   }];

inpForm.fname  = [inpForm.fname  {'extrap' 'fibo' 'optmem' 'binType' 'component'}];
inpForm.defval = [inpForm.defval {false    false  0        'ebin'    'Sperp'    }];
inpForm.size   = [inpForm.size   {[1 1]    [1 1]  [1 1]    [1 -4]     [1 -5]    }];

inpForm.fname  = [inpForm.fname  {'fid'}];
inpForm.defval = [inpForm.defval {fid  }];
inpForm.size   = [inpForm.size   {[1 1]}];

param  = sw_readparam(inpForm, varargin{:});

fid = param.fid;

% list of supported functions:
%   0:  unknown
%   1:  @spinwave
%   2:  @scga
funList = {@spinwave @scga};
funIdx  = [find(cellfun(@(C)isequal(C,param.specfun),funList)) 0];
funIdx  = funIdx(1);

if isempty(param.Evect) && funIdx == 1
    error('spinw:powspec:WrongOption','Energy bin vector is missing, use ''Evect'' option!');
end

% number of bins along energy
switch param.binType
    case 'cbin'
        nE      = numel(param.Evect);
    case 'ebin'
        nE      = numel(param.Evect) - 1;
end

nQ      = numel(hklA);
powSpec = zeros(max(1,nE),nQ);

fprintf0(fid,'Calculating powder spectra...\n');

% message for magnetic form factor calculation
yesNo = {'No' 'The'};
fprintf0(fid,[yesNo{param.formfact+1} ' magnetic form factor is'...
    ' included in the calculated structure factor.\n']);
% message for g-tensor calculation
fprintf0(fid,[yesNo{param.gtensor+1} ' g-tensor is included in the '...
    'calculated structure factor.\n']);

sw_status(0,1,param.tid,'Powder spectrum calculation');

if param.fibo
    % apply the Fibonacci numerical integration on a sphere
    % according to J. Phys. A: Math. Gen. 37 (2004) 11591
    % create QF points on the unit sphere
    
    [F,F1] = sw_fibo(param.nRand);
    param.nRand = F;
    
    QF = zeros(3,F);
    
    j = 0:(F-1);
    QF(3,:) = j*2/F-1;
    
    theta = asin(QF(3,:));
    phi   = 2*pi*F1/F*j;
    
    QF(1,:) = cos(theta).*sin(phi);
    QF(2,:) = cos(theta).*cos(phi);
    
end

% lambda value for SCGA, empty will make integration in first loop
specQ.lambda = [];

for ii = 1:nQ
    if param.fibo
        Q = QF*hklA(ii);
    else
        rQ  = randn(3,param.nRand);
        Q   = bsxfun(@rdivide,rQ,sqrt(sum(rQ.^2)))*hklA(ii);
    end
    hkl = (Q'*obj.basisvector)'/2/pi;
    
    switch funIdx
        case 0
            % general function call allow arbitrary additional parameters to
            % pass to the spectral calculation function
            warnState = warning('off','sw_readparam:UnreadInput');
            specQ = param.specfun(obj,hkl,varargin{:});
            warning(warnState);
        case 1
            % @spinwave
            specQ = spinwave(obj,hkl,struct('fitmode',true,'notwin',true,...
                'Hermit',param.hermit,'formfact',param.formfact,...
                'formfactfun',param.formfactfun,'gtensor',param.gtensor,...
                'optmem',param.optmem,'tid',0,'fid',0),'noCheck');
            
        case 2
            % @scga
            specQ = scga(obj,hkl,struct('fitmode',true,'formfact',param.formfact,...
                'formfactfun',param.formfactfun,'gtensor',param.gtensor,...
                'fid',0,'lambda',specQ.lambda,'nInt',param.nInt,'T',param.T,...
                'plot',false),'noCheck');
    end
    
    specQ = sw_neutron(specQ,'pol',false);
    specQ.obj = obj;
    % use edge grid by default
    specQ = sw_egrid(specQ,struct('Evect',param.Evect,'T',param.T,'binType',param.binType,...
    'imagChk',param.imagChk,'component',param.component),'noCheck');
    powSpec(:,ii) = sum(specQ.swConv,2)/param.nRand;
    sw_status(ii/nQ*100,0,param.tid);
end

sw_status(100,2,param.tid);

fprintf0(fid,'Calculation finished.\n');

% save different field into spectra
spectra.swConv    = powSpec;
spectra.hklA      = hklA;
spectra.component = param.component;
spectra.nRand    = param.nRand;
spectra.T        = param.T;
spectra.obj      = copy(obj);
spectra.norm     = false;
spectra.formfact = specQ.formfact;
spectra.gtensor  = specQ.gtensor;
spectra.date     = datestr(now);
spectra.title    = param.title;
% save all input parameters of spinwave into spectra
spectra.param    = specQ.param;

% some spectral function dependent parameters
switch funIdx
    case 0
        spectra.Evect    = specQ.Evect;
    case 1
        spectra.Evect    = specQ.Evect;
        spectra.incomm   = specQ.incomm;
        spectra.helical  = specQ.helical;
    case 2
        spectra.lambda   = specQ.lambda;
end

end