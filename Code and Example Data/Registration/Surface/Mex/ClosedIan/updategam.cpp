#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *gamupdated, *gamidd;
	int n, t;
	const double *gamupdate, *gamid;
	double *gamnew, eps;

	if (nrhs != 3)
		mexErrMsgTxt("usage: [gamnew] = updategam(gamupdate,gamid,eps)");

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[1]) != 3)
		mexErrMsgTxt("First and second argument expected to be 3 dimensional.");

	gamupdated = mxGetDimensions(prhs[0]);
	gamidd = mxGetDimensions(prhs[1]);

	if (gamidd[0] != gamupdated[0] || gamidd[1] != gamupdated[1] || gamidd[2] != gamupdated[2])
		mexErrMsgTxt("First and second argument expected to equal dimensions.");

	if (gamupdated[2] != 2)
		mexErrMsgTxt("Third dimension expected to be 2");

	if (mxGetNumberOfElements(prhs[2]) != 1)
		mexErrMsgTxt("Third argument expected to be scalar.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	n = gamupdated[0];
	t = gamupdated[1];

	plhs[0] = (mxArray *)mxCreateNumericArray(3,gamidd,mxDOUBLE_CLASS,mxREAL);

	gamnew = mxGetPr(plhs[0]);
	gamupdate = mxGetPr(prhs[0]);
	gamid = mxGetPr(prhs[1]);
	eps = *mxGetPr(prhs[2]);

	updategam(gamnew,gamupdate,gamid,eps,n,t);
}
