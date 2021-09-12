#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const double *F;
	double *Snorm, *A, *A_tmp1, *A_tmp2;
	const int *dims;
	int n, t, d;

	if (nrhs != 1)
		mexErrMsgTxt("[A,A_tmp1,A_tmp2] = area_surf_closed(F).");

	if (!mxIsDouble(prhs[0]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("Expected 3 dimensional matrix argument.");

	dims = mxGetDimensions(prhs[0]);
	n = dims[0];
	t = dims[1];
	d = dims[2];

	if (d != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	if (n != t)
		mexErrMsgTxt("Expected n = t.");

	if (nlhs != 4)
		mexErrMsgTxt("Expected 4 returns.");

	plhs[0] = mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);
	plhs[1] = mxCreateDoubleScalar(0);
	plhs[2] = mxCreateDoubleMatrix(n,t,mxREAL);
	plhs[3] = mxCreateDoubleMatrix(n,t,mxREAL);

	F = mxGetPr(prhs[0]);
	Snorm = mxGetPr(plhs[0]);
	A = mxGetPr(plhs[1]);
	A_tmp1 = mxGetPr(plhs[2]);
	A_tmp2 = mxGetPr(plhs[3]);

	area_surf_closed(Snorm,A,A_tmp1,A_tmp2,F,n,t);
}