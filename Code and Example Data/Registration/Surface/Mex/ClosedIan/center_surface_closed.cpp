#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int n, t, d;
	const int *dims;
	const double *F, *multfact, *Theta;
	double *Fnew, A;

	if (nrhs != 4) 
		mexErrMsgTxt("usage: Fnew = center_surface_closed(F,multfact,A,Theta).");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]) || !mxIsDouble(prhs[3]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("First argument expected to be 3 dimensional.");

	if (mxGetNumberOfDimensions(prhs[1]) != 2 || mxGetNumberOfDimensions(prhs[3]) != 2)
		mexErrMsgTxt("Second and fourth arguments expected to be 2 dimensional.");

	dims = mxGetDimensions(prhs[0]);

	n = dims[0];
	t = dims[1];
	d = dims[2];

	if (d != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	dims = mxGetDimensions(prhs[1]);
	if (dims[0] != n || dims[1] != t)
		mexErrMsgTxt("Dimension mismatch in second argument.");

	dims = mxGetDimensions(prhs[3]);
	if (dims[0] != n || dims[1] != t)
		mexErrMsgTxt("Dimension mismatch in fourth argument.");

	if (mxGetNumberOfElements(prhs[2]) != 1)
		mexErrMsgTxt("Third argument expected to be scalar.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	dims = mxGetDimensions(prhs[0]);
	plhs[0] = (mxArray *)mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);

	Fnew = mxGetPr(plhs[0]);
	F = mxGetPr(prhs[0]);
	multfact = mxGetPr(prhs[1]);
	A = *mxGetPr(prhs[2]);
	Theta = mxGetPr(prhs[3]);

	center_surface_closed(Fnew,F,multfact,A,Theta,n,t);
}
