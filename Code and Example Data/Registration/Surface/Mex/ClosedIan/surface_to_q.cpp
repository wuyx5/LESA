#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int n, t, d;
	const int *dims;
	const double *f, *multfact;
	double *q;

	if (nrhs != 2)
		mexErrMsgTxt("usage: q = surface_to_q(f,multfact).");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("Expected 3 dimensional matrix argument.");

	if (mxGetNumberOfDimensions(prhs[1]) != 2)
		mexErrMsgTxt("Expected 2 dimensional matrix argument.");

	dims = mxGetDimensions(prhs[0]);
	n = dims[0];
	t = dims[1];
	d = dims[2];

	dims = mxGetDimensions(prhs[1]);
	if (d != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	if (dims[0] != n || dims[1] != t)
		mexErrMsgTxt("Dimension mismatch in second argument.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	dims = mxGetDimensions(prhs[0]);
	plhs[0] = (mxArray *)mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);

	f = mxGetPr(prhs[0]);
	multfact = mxGetPr(prhs[1]);
	q = mxGetPr(plhs[0]);

	surface_to_q(q,f,multfact,n,t);
}
