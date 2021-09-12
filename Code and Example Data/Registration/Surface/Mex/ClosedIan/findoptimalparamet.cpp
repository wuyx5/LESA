#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *f1d, *f2d, *Thetad, *Phid;
	int n, t, dims[3], scale;
	const double *f1, *f2, *Theta, *Phi;
	double *f1new, *f2new, *A2new, *A_tmp12new, *A_tmp22new, *A_tmp21, *optdodeca, *optrot;

	if (nrhs != 5)
		mexErrMsgTxt("usage: [f1,f2new,A2new,A_tmp12new,A_tmp22new,A_tmp21,optdodeca,optrot]=findoptimalparamet(f1,f2,Theta,Phi,scale)");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]) || !mxIsDouble(prhs[3]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[1]) != 3)
		mexErrMsgTxt("First and second arguments expected to be three dimensional.");

	if (mxGetNumberOfDimensions(prhs[2]) != 2 || mxGetNumberOfDimensions(prhs[3]) != 2)
		mexErrMsgTxt("Third and fourth arguments expected to be matrices.");

	if (mxGetNumberOfElements(prhs[4]) != 1)
		mexErrMsgTxt("Fifth argument expected to be scalar.");

	f1d = mxGetDimensions(prhs[0]);
	f2d = mxGetDimensions(prhs[1]);
	Thetad = mxGetDimensions(prhs[2]);
	Phid = mxGetDimensions(prhs[3]);

	if (f1d[0] != f1d[1] || f2d[0] != f2d[1] || Thetad[0] != Thetad[1] || Phid[0] != Phid[1])
		mexErrMsgTxt("All arguments expected to be square in first two dimensions.");

	if (f1d[0] != f2d[0] || f1d[0] != Thetad[0] || f1d[0] != Phid[0])
		mexErrMsgTxt("All arguments expected to have matching first two dimensions.");

	if (f1d[2] != 3 || f2d[2] != 3)
		mexErrMsgTxt("Third dimension of first two arguments expected to be 3.");

	if (nlhs != 8)
		mexErrMsgTxt("Expected eight returns.");

	n = f1d[0];
	t = f1d[1];

	dims[0] = n;
	dims[1] = t;
	dims[2] = 2;

	plhs[0] = mxCreateNumericArray(3,f1d,mxDOUBLE_CLASS,mxREAL);
	plhs[1] = mxCreateNumericArray(3,f1d,mxDOUBLE_CLASS,mxREAL);
	plhs[2] = mxCreateDoubleScalar(0);
	plhs[3] = mxCreateDoubleMatrix(n,t,mxREAL);
	plhs[4] = mxCreateDoubleMatrix(n,t,mxREAL);
	plhs[5] = mxCreateDoubleMatrix(n,t,mxREAL);
	plhs[6] = mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);
	plhs[7] = mxCreateDoubleMatrix(3,3,mxREAL);

	f1new = mxGetPr(plhs[0]);
	f2new = mxGetPr(plhs[1]);
	A2new = mxGetPr(plhs[2]);
	A_tmp12new = mxGetPr(plhs[3]);
	A_tmp22new = mxGetPr(plhs[4]);
	A_tmp21 = mxGetPr(plhs[5]);
	optdodeca = mxGetPr(plhs[6]);
	optrot = mxGetPr(plhs[7]);
	f1 = mxGetPr(prhs[0]);
	f2 = mxGetPr(prhs[1]);
	Theta = mxGetPr(prhs[2]);
	Phi = mxGetPr(prhs[3]);
	scale = (mxGetScalar(prhs[4]) != 0);

	findoptimalparamet(f1new,f2new,A2new,A_tmp12new,A_tmp22new,A_tmp21,optdodeca,optrot,f1,f2,Theta,Phi,scale,n,t);
}