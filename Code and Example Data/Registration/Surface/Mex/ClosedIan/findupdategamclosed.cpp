#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *vd, *wd, *bd, *Thetad;
	int dims[3], n, t, a;
	const double *v, *w, *b, *Theta;
	double *gamupdate;

	if (nrhs != 4)
		mexErrMsgTxt("usage: gamupdate = findupdategamclosed(v,w,b,Theta)");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]) || !mxIsDouble(prhs[3]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("First argument expected to be three dimensional.");

	if (mxGetNumberOfDimensions(prhs[1]) != 4 || mxGetNumberOfDimensions(prhs[2]) != 4)
		mexErrMsgTxt("Second and third argument expected to be four dimensional.");

	if (mxGetNumberOfDimensions(prhs[3]) != 2)
		mexErrMsgTxt("Fourth argument expected to be two dimensional.");

	vd = mxGetDimensions(prhs[0]);
	wd = mxGetDimensions(prhs[1]);
	bd = mxGetDimensions(prhs[2]);
	Thetad = mxGetDimensions(prhs[3]);

	if (vd[0] != wd[0] || vd[1] != wd[1] || vd[2] != wd[2])
		mexErrMsgTxt("Dimension mismatch between arguments 1 and 2.");

	if (vd[2] != 3)
		mexErrMsgTxt("Third dimension of first argument expected to be 3.");

	if (vd[0] != bd[0] || vd[1] != bd[1])
		mexErrMsgTxt("Dimension mismatch between arguments 1 and 3.");

	if (vd[0] != Thetad[0] || vd[1] != Thetad[1])
		mexErrMsgTxt("Dimension mismatch between arguments 1 and 4.");

	if (wd[3] != bd[3])
		mexErrMsgTxt("Dimension mismatch between arguments 2 and 3.");

	if (bd[2] != 2)
		mexErrMsgTxt("Third dimension of third argument expected to be 2.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	n = wd[0];
	t = wd[1];
	a = wd[3];

	dims[0] = n;
	dims[1] = t;
	dims[2] = 2;

	plhs[0] = (mxArray *)mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);

	gamupdate = mxGetPr(plhs[0]);
	v = mxGetPr(prhs[0]);
	w = mxGetPr(prhs[1]);
	b = mxGetPr(prhs[2]);
	Theta = mxGetPr(prhs[3]);

	findupdategamclosed(gamupdate,v,w,b,Theta,n,t,a);
}
