#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	int dims[4];
	const int *bd, *q2d, *Psid, *Thetad;
	int n, t, a;
	double *w;
	const double *q2, *Psi, *b, *Theta;

	if (nrhs != 4)
		mexErrMsgTxt("usage: w = findphistarclosed(q2,Psi,b,Theta)");

	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]) || !mxIsDouble(prhs[3]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[1]) != 3)
		mexErrMsgTxt("First and second argument are expected to be three dimensional.");

	if (mxGetNumberOfDimensions(prhs[2]) != 4)
		mexErrMsgTxt("Third argument expected to be four dimensional.");

	if (mxGetNumberOfDimensions(prhs[3]) != 2)
		mexErrMsgTxt("Fourth argument expected to be two dimensional.");

	q2d = mxGetDimensions(prhs[0]);
	Psid = mxGetDimensions(prhs[1]);
	bd = mxGetDimensions(prhs[2]);
	Thetad = mxGetDimensions(prhs[3]);

	if (q2d[2] != 3)
		mexErrMsgTxt("Third dimension of first argument expected to be 3.");

	if (q2d[0] != Psid[0] || q2d[1] != Psid[1])
		mexErrMsgTxt("Dimension mismatch between arguments 1 and 2.");

	if (q2d[0] != bd[0] || q2d[1] != bd[1])
		mexErrMsgTxt("Dimension mismatch between arguments 1 and 3.");

	if (q2d[0] != Thetad[0] || q2d[1] != Thetad[1])
		mexErrMsgTxt("Dimension mismatch between arguments 1 and 4.");

	if (2*Psid[2] != bd[3])
		mexErrMsgTxt("Dimension 3 of argument 2 expected to be twice dimension 4 of argument 3.");

	if (bd[2] != 2)
		mexErrMsgTxt("Third dimension of the third argument expected to be 2.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	n = bd[0];
	t = bd[1];
	a = bd[3];

	dims[0] = n;
	dims[1] = t;
	dims[2] = 3;
	dims[3] = a;

	plhs[0] = (mxArray *)mxCreateNumericArray(4,dims,mxDOUBLE_CLASS,mxREAL);

	w = mxGetPr(plhs[0]);
	q2 = mxGetPr(prhs[0]);
	Psi = mxGetPr(prhs[1]);
	b = mxGetPr(prhs[2]);
	Theta = mxGetPr(prhs[3]);

	findphistarclosed(w,q2,Psi,b,Theta,n,t,a);
}