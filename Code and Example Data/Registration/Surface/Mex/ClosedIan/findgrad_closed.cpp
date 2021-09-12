#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int n, t, d;
	const int *dims;
	const double *f, *Theta;
	double *dfdu, *dfdv;

	if (nrhs != 2)
		mexErrMsgTxt("usage: [dfdu, dfdv] = findgrad_closed(f,Theta).");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("First argument expected to be 3 dimensional.");

	if (mxGetNumberOfDimensions(prhs[1]) != 2)
		mexErrMsgTxt("Second argument expected to be 2 dimensional.");

	dims = mxGetDimensions(prhs[0]);
	n = dims[0];
	t = dims[1];
	d = dims[2];

	if (d != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	if (n != t)
		mexErrMsgTxt("Expected n = t.");

	dims = mxGetDimensions(prhs[1]);
	if (dims[0] != n && dims[1] != t)
		mexErrMsgTxt("Dimension mismatch in second argument.");

	if (nlhs != 2)
		mexErrMsgTxt("Expected two returns.");

	dims = mxGetDimensions(prhs[0]);
	plhs[0] = (mxArray *)mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);
	plhs[1] = (mxArray *)mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);

	f = mxGetPr(prhs[0]);
	Theta = mxGetPr(prhs[1]);
	dfdu = mxGetPr(plhs[0]);
	dfdv = mxGetPr(plhs[1]);

	findgrad_closed(dfdu, dfdv, f, Theta, n, t);
}
