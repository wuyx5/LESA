#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *gamidd, *gamincd;
	int n;
	const double *gamid, *gaminc;
	double *gamcum;

	if (nrhs != 3)
		mexErrMsgTxt("gamcum = Apply_gam_gamid_closed(gamid,gaminc,n)");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[1]) != 3)
		mexErrMsgTxt("First two arguments expected to be 3D.");

	if (mxGetNumberOfElements(prhs[2]) != 1)
		mexErrMsgTxt("Third argument expected to be scalar.");

	n = mxGetScalar(prhs[2]);

	gamidd = mxGetDimensions(prhs[0]);
	gamincd = mxGetDimensions(prhs[1]);

	if (gamidd[0] != n || gamidd[1] != n)
		mexErrMsgTxt("First two dimensions expected to match third argument.");

	if (gamidd[2] != 2)
		mexErrMsgTxt("Third dimension expected to be 2.");

	if (gamincd[0] != gamidd[0] || gamincd[1] != gamidd[1] || gamincd[2] != gamidd[2])
		mexErrMsgTxt("Dimension mismatch between first two arguments.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	plhs[0] = mxCreateNumericArray(3,gamidd,mxDOUBLE_CLASS,mxREAL);

	gamcum = mxGetPr(plhs[0]);
	gamid = mxGetPr(prhs[0]);
	gaminc = mxGetPr(prhs[1]);

	Apply_gam_gamid_closed(gamcum, gamid, gaminc, n);
}
