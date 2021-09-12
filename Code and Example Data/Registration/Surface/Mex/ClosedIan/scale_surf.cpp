#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int n, t, d;
	const int *dims;
	const double *F;
	double *Fnew, A;

	if (nrhs != 2)
		mexErrMsgTxt("usage: Fnew = scale_surf(F,A)");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("First argument expected to be three dimensional.");

	dims = mxGetDimensions(prhs[0]);
	n = dims[0];
	t = dims[1];
	d = dims[2];

	if (d != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	if (mxGetNumberOfElements(prhs[1]) != 1)
		mexErrMsgTxt("Second argument expected to be scalar.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	plhs[0] = (mxArray *)mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);

	Fnew = mxGetPr(plhs[0]);
	F = mxGetPr(prhs[0]);
	A = *mxGetPr(prhs[1]);

	scale_surf(Fnew,F,A,n,t);
}
