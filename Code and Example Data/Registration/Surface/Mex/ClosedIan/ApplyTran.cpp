#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int n, t, d;
	const int *dims;
	double *qnew, *q, *T;

	if (nrhs != 2)
		mexErrMsgTxt("usage: qnew = ApplyTran(q,T).");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("Expected 3 dimensional matrix argument");

	dims = mxGetDimensions(prhs[0]);

	n = dims[0];
	t = dims[1];
	d = dims[2];
	
	if (d != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	if (mxGetM(prhs[1]) != 3 || mxGetN(prhs[1]) != 1)
		mexErrMsgTxt("Second argument expected to be 3x1.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	n = mxGetNumberOfElements(prhs[0]);

	q = mxGetPr(prhs[0]);
	T = mxGetPr(prhs[1]);

	plhs[0] = (mxArray *)mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);

	qnew = mxGetPr(plhs[0]);

	ApplyTran(qnew,q,T,n,t);
}