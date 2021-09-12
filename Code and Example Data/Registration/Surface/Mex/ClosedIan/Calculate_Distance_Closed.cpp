#include "mex.h"
#include "ClosedIan.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	const int *q1d, *q2d, *Thetad;
	int n, t;
	double *H;
	const double *q1, *q2, *Theta;

	if (nrhs != 3)
		mexErrMsgTxt("usage: H = Calculate_Distance_Closed(q1,q2,Theta)");
	
	if (!mxIsDouble(prhs[0]) || !mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]))
		mexErrMsgTxt("Expected double precision arguments.");

	if (mxGetNumberOfDimensions(prhs[0]) != 3 || mxGetNumberOfDimensions(prhs[1]) != 3)
		mexErrMsgTxt("First and second argument expected to be three dimensional.");

	if (mxGetNumberOfDimensions(prhs[2]) != 2)
		mexErrMsgTxt("Third argument expected to be two dimensional.");

	q1d = mxGetDimensions(prhs[0]);
	q2d = mxGetDimensions(prhs[1]);
	Thetad = mxGetDimensions(prhs[2]);

	if (q1d[0] != q2d[0] || q1d[1] != q2d[1] || q1d[2] != q2d[2])
		mexErrMsgTxt("Dimension mismatch between first and second arguments.");

	if (q1d[0] != Thetad[0] || q1d[1] != Thetad[1])
		mexErrMsgTxt("Dimension mismatch between first and third arguments.");

	if (q1d[2] != 3)
		mexErrMsgTxt("Third dimension expected to be 3.");

	if (nlhs != 1)
		mexErrMsgTxt("Expected one return.");

	n = q1d[0];
	t = q1d[1];

	plhs[0] = mxCreateDoubleScalar(0);

	H = mxGetPr(plhs[0]);
	q1 = mxGetPr(prhs[0]);
	q2 = mxGetPr(prhs[1]);
	Theta = mxGetPr(prhs[2]);

	Calculate_Distance_Closed(H,q1,q2,Theta,n,t);
}
